import 'package:flutter/foundation.dart';

enum TransactionType { Income, Expense }

// TODO: Remove TransactionType and just have the amount be negative. Make a getter string for a formatted output for the amount.
class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType transactionType;

  const Transaction({
    @required this.id,
    @required this.title,
    this.description = '',
    @required this.amount,
    @required this.date,
    @required this.transactionType,
  });
}
