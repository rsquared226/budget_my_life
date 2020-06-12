import 'package:flutter/foundation.dart';

enum TransactionType { Income, Expense }

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;

  const Transaction({
    @required this.id,
    @required this.title,
    this.description = '',
    @required this.amount,
    @required this.date,
  });

  String get formattedAmount {
    var formattedAmount = '\$${amount.abs().toStringAsFixed(2)}';
    if (amount < 0) {
      formattedAmount = '-' + formattedAmount;
    }
    return formattedAmount;
  }
}
