import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../charts_base/time_series_base.dart';
import '../chart_models/balance_history_model.dart';
import '../../providers/transactions.dart';

class BalanceHistoryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement range stuff
    final transactions = Provider.of<Transactions>(context, listen: false)
        .sevenDaysTransactions
        .reversed
        .toList();

    // Each TimeSeriesModel will contain one date with the sum of the transaction amounts from that specific day.
    final data = <BalanceHistoryModel>[];

    // Add up all the transactions in a format that's easier to read for the bar chart.
    transactions.forEach((transaction) {
      final amount = transaction.amount;
      if (data.length > 0 && transaction.date.compareTo(data.last.date) == 0) {
        if (amount > 0) {
          data.last.incomeAmount += amount;
        } else {
          // Make it positive so it shows up next to the income bars.
          data.last.expenseAmount += amount.abs();
        }
      } else {
        data.add(
          BalanceHistoryModel(
            date: transaction.date,
            incomeAmount: amount > 0 ? amount : 0,
            expenseAmount: amount < 0 ? amount.abs() : 0,
          ),
        );
      }
    });

    if (data.length < 2) {
      return const Center(
        child: Text(
          'Add some more transactions!',
          style: TextStyle(fontSize: 15),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TimeSeriesBase(
        id: 'Balance History',
        color: Colors.blueAccent,
        data: data,
      ),
    );
  }
}
