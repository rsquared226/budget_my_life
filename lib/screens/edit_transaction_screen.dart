import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../card_items/label_chooser_card.dart';
import '../models/transaction.dart';
import '../models/label.dart';
import '../providers/transactions.dart';
import '../providers/labels.dart';
import '../widgets/edit_transaction_appbar.dart';

// This is what pops up when the FAB on home_screen is clicked.

// This is to make the saving of the form less cumbersome.
class EditableTransaction {
  // If a transaction is being edited, the id should never change.
  // If a transaction is being added, the id will be null until it is converted to a Label.
  final String id;
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
  // Default date should be now. Also remove time on the date. If the time is there, it messes up the balance history
  // graph.
  var _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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

  Future<Label> _showLabelPicker() {
    return showDialog<Label>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select a label'),
          children: <Widget>[
            // Create a bunch of dialog options based on the labels the user has.
            _labelPickerHeader('Income'),
            ..._getLabelChooserList(_labelsData.incomeLabels),
            _labelPickerHeader('Expense'),
            ..._getLabelChooserList(_labelsData.expenseLabels),
          ],
        );
      },
    );
  }

  Widget _labelPickerHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
      ),
    );
  }

  List<Widget> _getLabelChooserList(List<Label> labelsList) {
    return labelsList.map(
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
    ).toList(growable: false);
  }

  String _checkLabelExistance(String labelId, bool isAmountNegative) {
    if (_labelsData.findById(labelId) == null) {
      return isAmountNegative ? Labels.otherExpenseId : Labels.otherIncomeId;
    }
    return labelId;
  }

  @override
  void initState() {
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
        labelId: _checkLabelExistance(initTx.labelId, initTx.amount < 0),
      );
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
    _amountFocusNode.dispose();
    _dateController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  String get submitButtonText {
    final addOrEdit = widget.editTransactionId != null ? 'SAVE ' : 'ADD ';
    final incomeOrExpense =
        (_selectedLabel.labelType == LabelType.INCOME) ? 'INCOME' : 'EXPENSE';
    return addOrEdit + incomeOrExpense;
  }

  Color get onPrimaryColor => Theme.of(context).colorScheme.onPrimary;

  String get initialAmountFieldValue {
    final initialVal = _editableTransaction.amount;
    return initialVal == null ? '' : initialVal.toStringAsFixed(2);
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
                  CustomColors.labelTypeColor(_selectedLabel.labelType),
              closeScreen: widget.closeContainer,
              submitButtonText: submitButtonText,
              onButtonSubmit: _saveForm,
              titleFormField: TextFormField(
                initialValue: _editableTransaction.title ?? '',
                textCapitalization: TextCapitalization.words,
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
                    initialValue: initialAmountFieldValue,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
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
                      // If it is an income transaction, make sure the number is positive. Don't check for sign when it
                      // is an expense transaction because some users would prefer to do either positive or negative
                      // amount inputs.
                      if (_selectedLabel.labelType == LabelType.INCOME &&
                          amountVal < 0) {
                        return 'Please enter a positive number';
                      }
                      if (double.parse(amountVal.toStringAsFixed(2)) !=
                          amountVal) {
                        return 'Please enter a number with a maximum of 2 decimal digits';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      // The difference between income and expense transactions are still kept by the sign of the
                      // amount. Ensure the sign is correct according to the label type.
                      if (_selectedLabel.labelType == LabelType.INCOME) {
                        _editableTransaction.amount =
                            double.parse(newValue).abs();
                      } else {
                        _editableTransaction.amount =
                            -double.parse(newValue).abs();
                      }
                    },
                  ),
                  const SizedBox(height: 7),
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
                    textCapitalization: TextCapitalization.sentences,
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
