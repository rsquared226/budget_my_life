import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TransactionHistoryModel {
  final DateTime date;
  double incomeAmount;
  double expenseAmount;

  TransactionHistoryModel({
    @required this.date,
    @required this.incomeAmount,
    @required this.expenseAmount,
  });

  String get dateString => DateFormat.E().format(date);
}
