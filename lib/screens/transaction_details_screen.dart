import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(
              <Widget>[
                Text(
                  transaction.title,
                  style: appTheme.textTheme.headline6.copyWith(
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: 10),
                // TODO: Make this a getter method in transactions model.
                Text(
                  DateFormat.yMMMMd().format(transaction.date),
                  style: appTheme.textTheme.caption.copyWith(
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 15),
                // TODO: Put graphs here.
                Placeholder(fallbackHeight: 250),
                SizedBox(height: 15),
                Text(
                  transaction.description,
                  style: appTheme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
