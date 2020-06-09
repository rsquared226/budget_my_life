import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../custom_colors.dart';
import '../models/transaction.dart';
import '../providers/transactions.dart';

// This is what pops up when the FAB on home_screen is clicked.

// This is to make the saving of the form less cumbersome.
class EditableTransaction {
  String id;
  String title;
  String description;
  double amount;
  DateTime date;

  EditableTransaction({
    this.id,
    this.title,
    this.description,
    this.amount,
    this.date,
  });

  Transaction toTransaction() {
    final transactionType =
        amount > 0 ? TransactionType.Income : TransactionType.Expense;
    return Transaction(
      id: id ?? DateTime.now().toString(),
      title: title,
      description: description,
      amount: amount.abs(),
      date: date,
      transactionType: transactionType,
    );
  }
}

class EditTransactionScreen extends StatefulWidget {
  // Function that closes this screen.
  final Function closeContainer;

  const EditTransactionScreen({@required this.closeContainer});

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  var _editableTransaction = EditableTransaction();

  // Used for determining what color the form header should be based on if it's positive or negative.
  final _amountController = TextEditingController();
  // Default date should be now.
  var _selectedDate = DateTime.now();
  // To set the text inside the date text field.
  final _dateController = TextEditingController();

  final _amountFocusNode = FocusNode();

  // The header containing the close button, section title, and the title form field.
  Widget _buildFormHeader(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    final amount = double.tryParse(_amountController.text);
    // By default we will assume the transaction is an income.
    final containerColor = amount != null && amount < 0
        ? CustomColors.expenseColor
        : CustomColors.incomeColor;
    final stringTransactionType =
        amount != null && amount < 0 ? 'Expense' : 'Income';

    Widget buildCloseButton() => IconButton(
          // Padding is 0 to get icon to align with the title form field.
          padding: const EdgeInsets.all(0),
          alignment: Alignment.topLeft,
          icon: Icon(
            Icons.close,
            color: onPrimaryColor,
          ),
          onPressed: widget.closeContainer,
        );

    // Had to do this hacky ButtonTheme stuff to get it aligned to the close button.
    // TODO: make this unhacky
    Widget buildSubmitButton() => ButtonTheme(
          height: 0,
          padding: const EdgeInsets.only(bottom: 20, left: 20),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: FlatButton(
            child: Text(
              'Add $stringTransactionType',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: onPrimaryColor,
                  ),
            ),
            onPressed: _saveForm,
          ),
        );

    Widget buildTitleFormField() => TextFormField(
          decoration: InputDecoration(
            labelText: 'Title',
            labelStyle: TextStyle(color: onPrimaryColor),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: onPrimaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          autofocus: true,
          style: TextStyle(color: onPrimaryColor),
          cursorColor: Theme.of(context).accentColor,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_amountFocusNode);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a title.';
            }
            if (value.length > 50) {
              return 'Please shorten your title from ${value.length} characters to 50.';
            }
            return null;
          },
          onSaved: (newValue) {
            _editableTransaction.title = newValue;
          },
        );

    return AnimatedContainer(
      height: 200,
      width: double.infinity,
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: containerColor,
        // Just so it can have a neat shadow under the header.
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 3,
            blurRadius: 3,
          ),
        ],
      ),
      // SafeArea here so that the close button is not in status bar. We don't want SafeArea surrounding the Container
      // because we want part of the colored Container to be under the status bar to look better.
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildCloseButton(),
                  buildSubmitButton(),
                ],
              ),
              SizedBox(height: 12),
              buildTitleFormField(),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Provider.of<Transactions>(context, listen: false)
        .addTransaction(_editableTransaction.toTransaction());
    widget.closeContainer();
  }

  @override
  void initState() {
    // Ensure that the section header color/button is updated when the amount field is updated.
    _amountController.addListener(() {
      setState(() {});
    });

    _dateController.text = DateFormat.yMMMMd().format(_selectedDate);
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildFormHeader(context),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        helperText:
                            'If this is an expense, make the amount negative.',
                      ),
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final amountVal = double.tryParse(value);
                        if (value.isEmpty || amountVal == null) {
                          return 'Please enter a number';
                        }
                        if (amountVal == 0) {
                          return 'Please enter a non-zero number';
                        }
                        if (double.parse(amountVal.toStringAsFixed(2)) !=
                            amountVal) {
                          return 'Please enter a number with a maximum of 2 decimal digits';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _editableTransaction.amount = double.parse(newValue);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                        helperText: 'Click to change the date',
                      ),
                      readOnly: true,
                      onTap: () async {
                        final DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.utc(1970),
                          lastDate: DateTime.now().add(Duration(days: 1)),
                          helpText: 'When did your transaction take place?',
                        );
                        if (pickedDate != null) {
                          _dateController.text =
                              DateFormat.yMMMMd().format(pickedDate);
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      controller: _dateController,
                      onSaved: (_) {
                        _editableTransaction.date = _selectedDate;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 4,
                      onSaved: (newValue) {
                        _editableTransaction.description = newValue;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
