import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../charts_base/time_series_base.dart';
import '../chart_models/balance_history_model.dart';
import '../../providers/insights_range.dart';
import '../../providers/transactions.dart';

class BalanceHistoryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of transactions in chronological order (oldest first).
    final range = Provider.of<InsightsRange>(context).range;
    final transactions = Provider.of<Transactions>(context, listen: false)
        .filterTransactionsByRange(range)
        .reversed
        .toList();

    // Each TimeSeriesModel will contain one date with the sum of the transaction amounts from that specific day.
    final data = <BalanceHistoryModel>[];

    // TODO: Do calculations here.

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
