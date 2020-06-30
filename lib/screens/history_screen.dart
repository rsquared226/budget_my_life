import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card_items/transaction_card.dart';
import '../screens/transaction_details_screen.dart';
import '../providers/transactions.dart';
import '../widgets/balance_summary_card.dart';

// This screen is a tab under home_screen.
// TODO: Use slivers
class HistoryScreen extends StatelessWidget {
  // Contains History text and dropdown filter.
  Widget buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'History',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          // TODO: add stuff here when categories are finished.
          // Idea: have the dropdown highlighted when an actual filter is selected.
          DropdownButton<String>(
            icon: const Icon(Icons.filter_list),
            items: [
              DropdownMenuItem(
                child: const Text('All'),
              ),
            ],
            onChanged: (newVal) {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final transactions = transactionsData.items;

    return Column(
      children: <Widget>[
        BalanceSummaryCard(
          balance: transactionsData.balance,
          formattedBalance: transactionsData.formattedBalance,
        ),
        const SizedBox(height: 8),
        buildListHeader(),
        const SizedBox(height: 5),
        // A psuedo-shadow.
        const Divider(
          height: 0,
          thickness: 1.5,
        ),
        Expanded(
          child: ListView.builder(
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
          ),
        ),
      ],
    );
  }
}
