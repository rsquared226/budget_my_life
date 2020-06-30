import 'package:flutter/material.dart';

import '../custom_colors.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // No need to surround this with a card because it is surrounded by OpenContainer in HistoryScreen.
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            // Need to align the square in the center (height) of the card.
            leading: Align(
              // Don't have Align take up entire ListTile width.
              widthFactor: 1,
              // Small rounded square to easily show if it is an income or expense.
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: CustomColors.transactionTypeColor(transaction.amount),
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
            trailing: Text(
              transaction.formattedAmount,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                transaction.formattedDate,
                style: theme.textTheme.caption,
              ),
              Chip(
                padding: const EdgeInsets.all(0),
                backgroundColor: theme.cardColor,
                avatar: CircleAvatar(
                  maxRadius: 7,
                  backgroundColor: transaction.getLabel(context).color,
                ),
                label: Text(
                  transaction.getLabel(context).title,
                  style: theme.textTheme.caption,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
