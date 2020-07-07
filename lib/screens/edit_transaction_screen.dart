import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../custom_colors.dart';
import '../card_items/label_chooser_card.dart';
import '../models/transaction.dart';
import '../models/label.dart';
import '../providers/transactions.dart';
import '../providers/labels.dart';
import '../widgets/edit_transaction_appbar.dart';

// This is what pops up when the FAB on home_screen is clicked.

// This is to make the saving of the form less cumbersome.
class EditableTransaction {
  String id;
  String title;
  String description;
  double amount;
  DateTime date;
  String labelId;

  EditableTransaction({
    this.id,
    this.title,
    this.description,
    this.amount,
    this.date,
    this.labelId,
  });

  Transaction toTransaction() {
    return Transaction(
      // If we are editing a transaction, an id would've already been provided. If not, we're making a new one and will
      // make a new id on the fly.
      id: id ?? DateTime.now().toString(),
      title: title,
      description: description,
      amount: amount,
      date: date,
      labelId: labelId,
    );
  }
}

class EditTransactionScreen extends StatefulWidget {
  // Function that closes this screen.
  final Function closeContainer;
  // Optional parameter, can be filled with a product id if we want to edit that product.
  final String editTransactionId;

  const EditTransactionScreen({
    @required this.closeContainer,
    this.editTransactionId,
  });

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  // The provider data is initialized later because it requires context.
  Transactions _transactionsData;
  Labels _labelsData;

  // This is initialized in initState so we can see if we're editing or adding a transaction.
  EditableTransaction _editableTransaction;

  // Used for determining what color the form header should be based on the LabelType.
  final _labelController = TextEditingController();
  // Initialized later and determines what is shown in the Label FormField.
  // Mostly needed for the color of the label text field.
  Label _selectedLabel;
  // Used for determining what color the form header should be based on if it's positive or negative.
  // TODO: Don't use this to determine form header color, use _selectedLabel instead.
  final _amountController = TextEditingController();
  // Default date should be now.
  var _selectedDate = DateTime.now();
  // To set the text inside the date text field.
  final _dateController = TextEditingController();

  final _amountFocusNode = FocusNode();

  void _saveForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (_editableTransaction.id != null) {
      _transactionsData.editTransaction(_editableTransaction.toTransaction());
    } else {
      _transactionsData.addTransaction(_editableTransaction.toTransaction());
    }
    widget.closeContainer();
  }

  // TODO: Separate income and expense labels.
  Future<Label> _showLabelPicker() {
    final labels = _labelsData.items;
    return showDialog<Label>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select a label'),
          children: <Widget>[
            // Create a bunch of dialog options based on the labels the user has.
            ...labels.map(
              (label) {
                return SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, label);
                  },
                  child: LabelChooserCard(
                    color: label.color,
                    title: label.title,
                  ),
                );
              },
            ).toList(growable: false),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // Ensure that the section header color/button is updated when the amount field is updated.
    _amountController.addListener(() {
      setState(() {});
    });

    _transactionsData = Provider.of<Transactions>(context, listen: false);
    _labelsData = Provider.of<Labels>(context, listen: false);

    if (widget.editTransactionId != null) {
      final initTx = _transactionsData.findById(widget.editTransactionId);

      _editableTransaction = EditableTransaction(
        id: initTx.id,
        title: initTx.title,
        amount: initTx.amount,
        date: initTx.date,
        description: initTx.description,
        labelId: initTx.labelId,
      );

      _amountController.text =
          _editableTransaction.amount.toStringAsFixed(2) ?? '';
      // Don't forget to set the selectedDate.
      _selectedDate = initTx.date;
    } else {
      _editableTransaction = EditableTransaction(labelId: Labels.otherIncomeId);
    }

    _selectedLabel = _labelsData.findById(_editableTransaction.labelId);
    _labelController.text = _selectedLabel.title;
    _dateController.text = DateFormat.yMMMMd().format(_selectedDate);

    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  double get parsedAmountField {
    return double.tryParse(_amountController.text);
  }

  String get submitButtonText {
    final addOrEdit = widget.editTransactionId != null ? 'Edit ' : 'Add ';
    final incomeOrExpense = (parsedAmountField != null && parsedAmountField > 0)
        ? 'Income'
        : 'Expense';
    return addOrEdit + incomeOrExpense;
  }

  Color get onPrimaryColor {
    return Theme.of(context).colorScheme.onPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            EditTransactionAppbar(
              containerColor:
                  CustomColors.transactionTypeColor(parsedAmountField),
              closeScreen: widget.closeContainer,
              submitButtonText: submitButtonText,
              onButtonSubmit: _saveForm,
              titleFormField: TextFormField(
                initialValue: _editableTransaction.title ?? '',
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: onPrimaryColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: onPrimaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
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
              ),
            ),
            // Expanded so it doesn't overflow when keyboard pops up.
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Label',
                      helperText: 'Click to change the label',
                      icon: CircleAvatar(
                        maxRadius: 12,
                        backgroundColor: _selectedLabel.color,
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final newLabel = await _showLabelPicker();
                      // The user clicked out of the dialog.
                      if (newLabel == null) {
                        return;
                      }
                      setState(() {
                        _selectedLabel = newLabel;
                      });
                      _labelController.text = newLabel.title;
                    },
                    controller: _labelController,
                    onSaved: (_) {
                      _editableTransaction.labelId = _selectedLabel.id;
                    },
                  ),
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
                      // TODO: only allow positive values.
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
                    initialValue: _editableTransaction.description ?? '',
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
          ],
        ),
      ),
    );
  }
}
