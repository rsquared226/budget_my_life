import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

import '../card_items/transaction_card.dart';
import '../providers/filter.dart';
import '../providers/transactions.dart';
import '../screens/transaction_details_screen.dart';

// Used in HistoryScreen.

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filterLabelId = Provider.of<Filter>(context).labelId;
    final transactions = Provider.of<Transactions>(context)
        .filterTransactions(context, filterLabelId);

    if (transactions.length == 0) {
      return const Center(
        child: Text('Start adding some transactions!'),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (_, index) {
        return Column(
          children: <Widget>[
            OpenContainer(
              closedShape: const BeveledRectangleBorder(),
              closedElevation: 0,
              closedBuilder: (_, __) {
                return TransactionCard(transaction: transactions[index]);
              },
              openBuilder: (_, __) {
                return TransactionDetailsScreen(
                  transactionId: transactions[index].id,
                );
              },
            ),
            const Divider(height: 1),
          ],
        );
      },
    );
  }
}
