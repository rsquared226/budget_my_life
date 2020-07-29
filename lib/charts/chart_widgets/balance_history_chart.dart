import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../charts_base/time_series_base.dart';
import '../chart_models/time_series_model.dart';
import '../../providers/transactions.dart';

class BalanceHistoryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of transactions in chronological order (oldest first).
    // TODO: Implement range in transactions provider.
    final transactions = Provider.of<Transactions>(context, listen: false)
        .items
        .reversed
        .toList();

    // Each TimeSeriesModel will contain one date with the sum of the transaction amounts from that specific day.
    final data = <TimeSeriesModel>[];

    transactions.forEach(
      (transaction) {
        // Checks if the dates are the same. If they are, add the value to the same day.
        // Also check to see whether they are in range or not.
        if (data.length > 0 &&
            data.last.date.compareTo(transaction.date) == 0) {
          // Can't update the value directly since it is declared as final.
          final updatedTimeSeriesModel = TimeSeriesModel(
            date: transaction.date,
            value: data.last.value + transaction.amount,
          );
          data.removeLast();
          data.add(updatedTimeSeriesModel);
        } else {
          data.add(
            TimeSeriesModel(
              date: transaction.date,
              value:
                  transaction.amount + (data.isNotEmpty ? data.last.value : 0),
            ),
          );
        }
      },
    );

    if (data.length < 3) {
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
