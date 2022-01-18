import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

// This is used in TransactionDetailsScreen.

class TransactionDetailsAppBar extends StatelessWidget {
  final double? transactionAmount;
  final String formattedAmount;
  final Function editTransaction;
  final Function deleteTransaction;

  const TransactionDetailsAppBar({
    required this.transactionAmount,
    required this.formattedAmount,
    required this.editTransaction,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 150,
      pinned: true,
      backgroundColor: appTheme.colorScheme.surface,
      // This makes the status bar icons grey in light mode and white in dark
      // mode so the user's status bar is readable.
      brightness: Theme.of(context).brightness,
      iconTheme: IconThemeData(color: appTheme.colorScheme.onSurface),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.blue.shade800,
          ),
          onPressed: editTransaction as void Function()?,
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red.shade900,
          ),
          onPressed: deleteTransaction as void Function()?,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .transactionTypeColor(transactionAmount),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            formattedAmount,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onIncomeExpenseColor,
            ),
          ),
        ),
      ),
    );
  }
}
