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
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 8,
        ),
        leading: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: transactionType == TransactionType.Income
                ? Colors.green
                : Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        title: Text(
          title,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: Text(
          '\$${amount.toStringAsFixed(2)}',
          softWrap: false,
          overflow: TextOverflow.fade,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
