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
    final transactionsData = Provider.of<Transactions>(context);
    final filteredTransactions =
        transactionsData.filterTransactions(context, filterLabelId);

    if (transactionsData.items.isEmpty) {
      return const Center(
        child: Text('Start adding some transactions!'),
      );
    }

    if (filteredTransactions.isEmpty) {
      return const Center(
        child: Text('No transactions for this filter!'),
      );
    }

    return ListView.separated(
      itemCount: filteredTransactions.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, index) {
        return OpenContainer(
          closedShape: const BeveledRectangleBorder(),
          closedElevation: 0,
          closedBuilder: (_, __) {
            return TransactionCard(transaction: filteredTransactions[index]);
          },
          openBuilder: (_, __) {
            return TransactionDetailsScreen(
              transactionId: filteredTransactions[index].id,
            );
          },
        );
      },
    );
  }
}
