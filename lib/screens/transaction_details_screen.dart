import 'package:flutter/material.dart';

import '../custom_colors.dart';
import '../models/transaction.dart';

// This is shown when a user clicks on a transaction card in HistoryScreen.

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsScreen({@required this.transaction});

  Widget buildAppBar(ThemeData appTheme) {
    return SliverAppBar(
      expandedHeight: 150,
      pinned: true,
      backgroundColor: appTheme.colorScheme.surface,
      iconTheme: IconThemeData(color: appTheme.colorScheme.onSurface),
      actions: <Widget>[
        // TODO: Actually link these buttons to stuff.
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: CustomColors.transactionTypeColor(transaction.amount),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            transaction.formattedAmount,
            style: TextStyle(
              color: CustomColors.onIncomeExpenseColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        buildAppBar(appTheme),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            <Widget>[],
          ),
        ),
      ],
    );
  }
}
