import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BalanceHistoryModel {
  final DateTime date;
  final double incomeAmount;
  final double expenseAmount;

  const BalanceHistoryModel({
    @required this.date,
    @required this.incomeAmount,
    @required this.expenseAmount,
  });

  String get dateString => DateFormat.MMMd().format(date);
}
