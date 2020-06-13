import 'package:flutter/material.dart';

import '../custom_colors.dart';
import '../models/transaction.dart';

// This is shown when a user clicks on a transaction card in HistoryScreen.

class ViewTransactionScreen extends StatelessWidget {
  final Transaction transaction;

  const ViewTransactionScreen({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 150,
          pinned: true,
          backgroundColor:
              CustomColors.transactionTypeColor(transaction.amount),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(transaction.title),
            collapseMode: CollapseMode.parallax,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, __) {
              return ListTile(title: const Text('ugh'));
            },
            childCount: 50,
          ),
        ),
      ],
    );
  }
}
