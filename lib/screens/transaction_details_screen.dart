import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions.dart';
import './edit_transaction_screen.dart';
import '../widgets/transaction_details_appbar.dart';
import '../widgets/transaction_details_charts_view.dart';

// This is shown when a user clicks on a transaction card in HistoryScreen.

class TransactionDetailsScreen extends StatelessWidget {
  // Use a provider rather than actual data so that when the transaction is edited the changes are reflected.
  final String transactionId;

  const TransactionDetailsScreen({@required this.transactionId});

  void onEditTransaction(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTransactionScreen(
          closeContainer: () => Navigator.pop(context),
          editTransactionId: transactionId,
        ),
      ),
    );
  }

  Future<void> onDeleteTransaction(
      BuildContext context, Function deleteTransaction) async {
    if (!(await confirmDeleteTransaction(context))) {
      return;
    }
    deleteTransaction(transactionId);
    // Doing this will avoid animation errors. It pops everything and goes back to the homescreen so the
    // closeContainer animation won't play on a deleted transaction.
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  // Return true if the user wants to delete, false if they cancel.
  Future<bool> confirmDeleteTransaction(BuildContext context) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete transaction?'),
          content:
              const Text('Are you sure you want to delete this transaction?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCEL'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'DELETE',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
    // If the user clicks out of the dialog to dismiss, the result will be null. We will assume they don't want to
    // delete the transaction if they do that.
    return confirmDelete ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final transactionsData = Provider.of<Transactions>(context);
    final transaction = transactionsData.findById(transactionId);

    // This is needed for that split second after a transaction is deleted and this screen is still visible before
    // it is closed. Otherwise, a nasty error is thrown.
    if (transaction == null) {
      return Container();
    }

    return CustomScrollView(
      slivers: <Widget>[
        TransactionDetailsAppBar(
          transactionAmount: transaction.amount,
          formattedAmount: transaction.formattedAmount,
          editTransaction: () => onEditTransaction(context),
          deleteTransaction: () => onDeleteTransaction(
            context,
            transactionsData.deleteTransaction,
          ),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Chip(
                      backgroundColor: appTheme.colorScheme.surface,
                      avatar: CircleAvatar(
                        backgroundColor: transaction.getLabel(context).color,
                      ),
                      label: Text(transaction.getLabel(context).title),
                    ),
                    Text(
                      transaction.formattedDate,
                      style: appTheme.textTheme.caption.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TransactionDetailsChartsView(
                  transactionId: transactionId,
                ),
                const SizedBox(height: 20),
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
