import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/labels.dart';
import '../providers/transactions.dart';
import '../widgets/balance_summary_card.dart';
import '../widgets/label_filter_dropdown.dart';
import '../widgets/transactions_list.dart';

// This screen is a tab under home_screen.
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
          LabelFilterDropdown(),
        ],
      ),
    );
  }

  Future<void> fetchAndSetData(BuildContext context) async {
    Provider.of<Transactions>(context, listen: false).fetchAndSetTransactions();
    Provider.of<Labels>(context, listen: false).fetchAndSetLabels();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch and set data in this screen because it is the first screen the user sees.
    return FutureBuilder(
      future: fetchAndSetData(context),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: <Widget>[
            Consumer<Transactions>(
              builder: (_, transactionsData, __) {
                return BalanceSummaryCard(
                  balance: transactionsData.balance,
                  formattedBalance: transactionsData.formattedBalance,
                );
              },
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
              child: TransactionsList(),
            ),
          ],
        );
      },
    );
  }
}
