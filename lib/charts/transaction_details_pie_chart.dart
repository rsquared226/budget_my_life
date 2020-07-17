import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'chart_models/pie_chart_model.dart';
import '../utils/custom_colors.dart';

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

  List<charts.Series<PieChartModel, String>> get chartData {
    final otherTitle =
        'Other ' + (transactionAmount < 0 ? 'Expenses' : 'Income');
    final pieData = [
      PieChartModel(
        label: transactionTitle,
        amount: transactionAmount,
        color: CustomColors.transactionTypeColor(transactionAmount),
      ),
      PieChartModel(
        label: otherTitle,
        amount: totalAmount - transactionAmount,
        color: CustomColors.secondaryTransactionTypeColor(transactionAmount),
      ),
    ];
    return [
      charts.Series(
        id: transactionTitle,
        domainFn: (PieChartModel transactionData, _) => transactionData.label,
        measureFn: (PieChartModel transactionData, _) => transactionData.amount,
        colorFn: (PieChartModel transactionData, _) => transactionData.color,
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
