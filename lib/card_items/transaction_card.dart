import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final String id;
  final String title;
  final double amount;
  final TransactionType transactionType;

  const TransactionCard({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: transactionType == TransactionType.Income
              ? Colors.green.shade700
              : Colors.red.shade900,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "\$${amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
