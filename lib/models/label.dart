import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './transaction.dart';
import '../providers/insights_range.dart';
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

  double getLabelAmountTotal(BuildContext context) =>
      _getListAmountTotal(_getLabelTransactions(context));

  double getLabelMonthAmountTotal(BuildContext context) {
    final labelMonthTransactions = _getLabelTransactions(context);

    final today = DateTime.now();
    // The day before the beginning of the month.
    final beginningOfMonth = DateTime(today.year, today.month, 0);

    // Filtered Transactions from this month.
    _retainTransactionsAfterDate(labelMonthTransactions, beginningOfMonth);

    return _getListAmountTotal(labelMonthTransactions);
  }

  double getLabelTotalWithRange(BuildContext context, Range range) {
    final labelTransactions = _getLabelTransactions(context);

    switch (range) {
      case Range.lifetime:
        return getLabelAmountTotal(context);

      case Range.thirtyDays:
        final thirtyDaysRange = DateTime.now().subtract(Duration(days: 30));
        _retainTransactionsAfterDate(labelTransactions, thirtyDaysRange);
        return _getListAmountTotal(labelTransactions);
        break;

      case Range.sevenDays:
        final sevenDaysRange = DateTime.now().subtract(Duration(days: 7));
        _retainTransactionsAfterDate(labelTransactions, sevenDaysRange);
        return _getListAmountTotal(labelTransactions);
        break;

      default:
        // Just in case a future range is added and it's not implemented here.
        throw UnimplementedError('An unimplemented or null range was passed.');
    }
  }

  List<Transaction> _getLabelTransactions(BuildContext context) {
    return Provider.of<Transactions>(context, listen: false)
        .filterTransactionsByLabel(context, id);
  }

  double _getListAmountTotal(List<Transaction> transactionList) {
    return transactionList.fold<double>(
      0,
      (previousValue, transaction) => previousValue + transaction.amount,
    );
  }

  // Doesn't return anything, modifies the array itself (pass-by-reference).
  void _retainTransactionsAfterDate(
      List<Transaction> transactionList, DateTime date) {
    transactionList.retainWhere(
      (transaction) => transaction.date.isAfter(date),
    );
  }
}
