import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../charts_base/grouped_bar_chart_base.dart';
import '../chart_models/transaction_history_model.dart';
import '../../providers/transactions.dart';

class TransactionHistoryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context, listen: false)
        .sevenDaysTransactions
        .reversed
        .toList();

    // Each TimeSeriesModel will contain one date with the sum of the transaction amounts from that specific day.
    final data = <TransactionHistoryModel>[];

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
          TransactionHistoryModel(
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

    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // Add earliest and latest days if they're not already in the data set so the graph is consistent (for weekly so far).
    if (data.first.date.compareTo(today.subtract(Duration(days: 6))) != 0) {
      data.insert(
        0,
        TransactionHistoryModel(
          date: today.subtract(Duration(days: 6)),
          incomeAmount: 0,
          expenseAmount: 0,
        ),
      );
    }
    if (data.last.date.compareTo(today) < 0) {
      data.add(
        TransactionHistoryModel(
          date: today,
          incomeAmount: 0,
          expenseAmount: 0,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GroupedBarChartBase(
        id: 'Balance History',
        color: Colors.blueAccent,
        data: data,
      ),
    );
  }
}
