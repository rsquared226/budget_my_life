import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card_items/transaction_card.dart';
import '../providers/transactions.dart';

// This screen is a tab under home_screen.

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context).items;

    return ListView.builder(
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
    );
  }
}
