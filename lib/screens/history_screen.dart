import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card_items/filter_label_card.dart';
import '../card_items/transaction_card.dart';
import '../screens/transaction_details_screen.dart';
import '../models/transaction.dart';
import '../providers/labels.dart';
import '../providers/transactions.dart';
import '../widgets/balance_summary_card.dart';

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
          // Idea: have the dropdown highlighted when an actual filter is selected.
          Consumer<Labels>(
            builder: (_, labels, __) {
              return DropdownButton<String>(
                icon: const Icon(Icons.filter_list),
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: const FilterLabelCard(
                      title: 'All',
                      categoryColor: Colors.transparent,
                    ),
                  ),
                  ...labels.items.map(
                    (label) {
                      return DropdownMenuItem(
                        value: label.id,
                        child: FilterLabelCard(
                          title: label.title,
                          categoryColor: label.color,
                        ),
                      );
                    },
                  ).toList()
                ],
                onChanged: (newVal) {},
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTransactionsList(List<Transaction> transactions) {
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
        return Consumer<Transactions>(
          builder: (_, transactionsData, __) {
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
                  child: buildTransactionsList(transactionsData.items),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
