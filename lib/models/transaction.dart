import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './label.dart';
import '../providers/labels.dart';

enum TransactionType { Income, Expense }

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String labelId;

  const Transaction({
    @required this.id,
    @required this.title,
    this.description = '',
    @required this.amount,
    @required this.date,
    @required this.labelId,
  });

  String get formattedAmount {
    var formattedAmount = '\$${amount.abs().toStringAsFixed(2)}';
    if (amount < 0) {
      formattedAmount = '-' + formattedAmount;
    }
    return formattedAmount;
  }

  String get formattedDate {
    return DateFormat.yMMMMd().format(date);
  }

  // Have this here so that when outputting a transaction, 2 providers aren't needed.
  Label getLabel(BuildContext context) {
    final labelsData = Provider.of<Labels>(context, listen: false);
    final label = labelsData.findById(labelId);
    // In case the label gets deleted/can't be found.
    if (label == null) {
      return labelsData
          .findById(amount > 0 ? Labels.otherIncomeId : Labels.otherExpenseId);
    }
    return label;
  }
}
