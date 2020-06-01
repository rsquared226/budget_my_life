import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card_items/transaction_card.dart';
import '../widgets/balance_summary_card.dart';
import '../providers/transactions.dart';

// This screen is a tab under home_screen.

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final transactions = transactionsData.items;

    return Column(
      children: <Widget>[
        BalanceSummaryCard(transactionsData.balance),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (_, index) {
              final transaction = transactions[index];
              return TransactionCard(
                id: transaction.id,
                title: transaction.title,
                amount: transaction.amount,
                transactionType: transaction.transactionType,
              );
            },
          ),
        ),
      ],
    );
  }
}
