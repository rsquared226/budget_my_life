import 'package:flutter/foundation.dart';

enum TransactionType { Income, Expense }

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final TransactionType transactionType;

  const Transaction({
    @required this.id,
    @required this.title,
    this.description = '',
    @required this.amount,
    @required this.transactionType,
  });
}
