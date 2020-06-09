import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card_items/transaction_card.dart';
import '../widgets/balance_summary_card.dart';
import '../providers/transactions.dart';

// This screen is a tab under home_screen.

class HistoryScreen extends StatelessWidget {
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
        BalanceSummaryCard(transactionsData.balance),
        SizedBox(height: 8),
        buildListHeader(),
        SizedBox(height: 5),
        // A psuedo-shadow.
        Divider(
          height: 0,
          thickness: 1.5,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (_, index) {
              return TransactionCard(transaction: transactions[index]);
            },
          ),
        ),
      ],
    );
  }
}
