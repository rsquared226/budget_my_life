import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../custom_colors.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({@required this.transaction});

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
          vertical: 2,
        ),
        // Need to align the square in the center (height) of the card.
        leading: Align(
          // Don't have Align take up entire ListTile width.
          widthFactor: 1,
          // Small rounded square to easily show if it is an income or expense.
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: transaction.transactionType == TransactionType.Income
                  ? CustomColors.incomeColor
                  : CustomColors.expenseColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        subtitle: Text(DateFormat.yMMMMd().format(transaction.date)),
        trailing: Text(
          '\$${transaction.amount.toStringAsFixed(2)}',
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
