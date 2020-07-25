import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './transaction.dart';
import '../providers/transactions.dart';

enum LabelType { INCOME, EXPENSE }

class Label {
  final String id;
  final String title;
  final Color color;
  final LabelType labelType;

  const Label({
    @required this.id,
    @required this.title,
    @required this.color,
    @required this.labelType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color.value,
      'labelType': labelType.index,
    };
  }

  static Label fromMap(Map<String, dynamic> map) {
    return Label(
      id: map['id'],
      title: map['title'],
      color: Color(map['color']),
      labelType: LabelType.values[map['labelType']],
    );
  }

  List<Transaction> _getLabelTransactions(BuildContext context) {
    return Provider.of<Transactions>(context, listen: false)
        .filterTransactions(context, id);
  }

  double _getListAmountTotal(List<Transaction> transactionList) {
    return transactionList.fold<double>(
      0,
      (previousValue, transaction) => previousValue + transaction.amount,
    );
  }

  double getLabelTotal(BuildContext context) =>
      _getListAmountTotal(_getLabelTransactions(context));

  double getLabelMonthTotal(BuildContext context) {
    final labelMonthTransactions = _getLabelTransactions(context);

    final today = DateTime.now();
    // The day before the beginning of the month.
    final beginningOfMonth = DateTime(today.year, today.month, 0);

    // Filtered Transactions from this month.
    labelMonthTransactions.retainWhere(
      (transaction) => transaction.date.isAfter(beginningOfMonth),
    );

    return _getListAmountTotal(labelMonthTransactions);
  }
}
