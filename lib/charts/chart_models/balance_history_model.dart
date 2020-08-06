import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BalanceHistoryModel {
  final DateTime date;
  double incomeAmount;
  double expenseAmount;

  BalanceHistoryModel({
    @required this.date,
    @required this.incomeAmount,
    @required this.expenseAmount,
  });

  String get dateString => DateFormat.MMMd().format(date);
}
