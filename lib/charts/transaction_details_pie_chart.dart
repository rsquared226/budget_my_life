import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import './chart_models/transaction_detail_chart_model.dart';
import '../custom_colors.dart';

// This is used in TransactionDetailsScreen.

class TransactionDetailsPieChart extends StatelessWidget {
  final String transactionTitle;
  final double transactionAmount;
  final double totalAmount;

  const TransactionDetailsPieChart({
    @required this.transactionTitle,
    @required this.transactionAmount,
    @required this.totalAmount,
  });

  List<charts.Series<TransactionDetailChartModel, String>> get chartData {
    final otherTitle =
        'Other ' + (transactionAmount < 0 ? 'Expenses' : 'Income');
    final pieData = [
      TransactionDetailChartModel(
        label: transactionTitle,
        amount: transactionAmount,
        color: CustomColors.transactionTypeColor(transactionAmount),
      ),
      TransactionDetailChartModel(
        label: otherTitle,
        amount: totalAmount - transactionAmount,
        color: CustomColors.secondaryTransactionTypeColor(transactionAmount),
      ),
    ];
    return [
      charts.Series(
        id: transactionTitle,
        domainFn: (TransactionDetailChartModel transactionData, _) =>
            transactionData.label,
        measureFn: (TransactionDetailChartModel transactionData, _) =>
            transactionData.amount,
        colorFn: (TransactionDetailChartModel transactionData, _) =>
            transactionData.color,
        data: pieData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      chartData,
      defaultRenderer: charts.ArcRendererConfig(
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.outside,
          ),
        ],
      ),
    );
  }
}
