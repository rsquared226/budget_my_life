import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../models/transaction.dart';

// Used in HistoryScreen.
// Design inspired by Todoist tasks at time of writing.

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({@required this.transaction});

  // This looks better than a chip.
  Widget buildCategoryLabel(
      ThemeData theme, String title, Color categoryColor) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: theme.textTheme.caption,
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          maxRadius: 6,
          backgroundColor: categoryColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // No need to surround this with a card because it is surrounded by OpenContainer in HistoryScreen.
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 5, 22, 10),
      child: Column(
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
                  color: Theme.of(context)
                      .colorScheme
                      .transactionTypeColor(transaction.amount),
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
              transaction.formattedAmount(context),
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Custom subtitle.
          Row(
            children: <Widget>[
              const SizedBox(width: 55),
              Icon(
                Icons.calendar_today,
                color: theme.hintColor,
                size: 15,
              ),
              const SizedBox(width: 4),
              Text(
                transaction.formattedDate,
                style: theme.textTheme.caption,
              ),
              const Spacer(),
              // Category label.
              buildCategoryLabel(
                theme,
                transaction.getLabel(context).title,
                transaction.getLabel(context).color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
