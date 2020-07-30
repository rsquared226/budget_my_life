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

  double getLabelMonthAmountTotal(BuildContext context) =>
      getLabelTotalWithRange(context, Range.month);

  double getLabelTotalWithRange(BuildContext context, Range range) {
    final labelTransactions = _getLabelTransactions(context);

    switch (range) {
      case Range.lifetime:
        return getLabelAmountTotal(context);

      case Range.month:
        labelTransactions.retainWhere(
          (transaction) => transaction.isAfterBeginningOfMonth,
        );
        return _getListAmountTotal(labelTransactions);
        break;

      case Range.week:
        labelTransactions.retainWhere(
          (transaction) => transaction.isAfterBeginningOfWeek,
        );
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
}
