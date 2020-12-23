import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

import '../card_items/transaction_card.dart';
import '../providers/filter.dart';
import '../providers/transactions.dart';
import '../screens/transaction_details_screen.dart';

// Used in HistoryScreen.

class TransactionsList extends StatelessWidget {
  SliverList buildEmptyListMessage(String message) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          const SizedBox(height: 20),
          Center(
            child: Text(message),
          ),
        ],
      ),
    );
  }

  @override
  SliverList build(BuildContext context) {
    final filterLabelId = Provider.of<Filter>(context).labelId;
    final transactionsData = Provider.of<Transactions>(context);
    final filteredTransactions =
        transactionsData.filterTransactionsByLabel(context, filterLabelId);

    if (transactionsData.items.isEmpty) {
      return buildEmptyListMessage('No transactions for this filter!');
    }

    if (filteredTransactions.isEmpty) {
      return buildEmptyListMessage('No transactions for this filter!');
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: <Widget>[
              OpenContainer(
                closedColor: Theme.of(context).cardColor,
                openColor: Theme.of(context).colorScheme.surface,
                closedShape: const BeveledRectangleBorder(),
                closedElevation: 0,
                closedBuilder: (_, __) {
                  return TransactionCard(
                    transaction: filteredTransactions[index],
                  );
                },
                openBuilder: (_, __) {
                  return TransactionDetailsScreen(
                    transactionId: filteredTransactions[index].id,
                  );
                },
              ),
              const Divider(height: 1),
            ],
          );
        },
        childCount: filteredTransactions.length,
      ),
    );
  }
}
