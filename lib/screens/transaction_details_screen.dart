import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions.dart';
import './edit_transaction_screen.dart';
import '../widgets/transaction_details_appbar.dart';

// This is shown when a user clicks on a transaction card in HistoryScreen.

class TransactionDetailsScreen extends StatelessWidget {
  // Use a provider rather than actual data so that when the transaction is edited the changes are reflected.
  final String transactionId;

  const TransactionDetailsScreen({@required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final transactionsData = Provider.of<Transactions>(context);
    final transaction = transactionsData.findById(transactionId);

    // This is needed for that split second after a transaction is deleted and and this screen is still visible before
    // it is closed. Otherwise, a nasty error is thrown.
    if (transaction == null) {
      return Container();
    }

    return CustomScrollView(
      slivers: <Widget>[
        TransactionDetailsAppBar(
          transactionAmount: transaction.amount,
          formattedAmount: transaction.formattedAmount,
          editTransaction: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditTransactionScreen(
                  closeContainer: () => Navigator.pop(context),
                  editTransactionId: transactionId,
                ),
              ),
            );
          },
          deleteTransaction: () {
            // TODO: add "are you sure" dialogue.
            transactionsData.deleteTransaction(transactionId);
            // Doing this will avoid animation errors. It pops everything and goes back to the homescreen so the
            // closeContainer animation won't play on a deleted transaction.
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(
              <Widget>[
                Text(
                  transaction.title,
                  style: appTheme.textTheme.headline6.copyWith(
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  transaction.formattedDate,
                  style: appTheme.textTheme.caption.copyWith(
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 15),
                // TODO: Put graphs here.
                Placeholder(fallbackHeight: 250),
                SizedBox(height: 15),
                Text(
                  transaction.description,
                  style: appTheme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
