import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/transaction_history_model.dart';
import '../../utils/custom_colors.dart';

class GroupedBarChartBase extends StatelessWidget {
  final String id;
  final List<TransactionHistoryModel> data;

  GroupedBarChartBase({
    required this.id,
    required Color color,
    required this.data,
  });

  charts.Color incomeChartColor(BuildContext context) =>
      convertToChartColor(Theme.of(context).colorScheme.incomeColor);

  charts.Color expenseChartColor(BuildContext context) =>
      convertToChartColor(Theme.of(context).colorScheme.expenseColor);

  charts.Color convertToChartColor(Color color) => charts.Color(
        r: color.red,
        g: color.green,
        b: color.blue,
        a: color.alpha,
      );

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<TransactionHistoryModel, String>> chartData = [
      charts.Series<TransactionHistoryModel, String>(
        id: id,
        colorFn: (_, __) => incomeChartColor(context),
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.incomeAmount,
        data: data,
      ),
      charts.Series<TransactionHistoryModel, String>(
        id: id,
        colorFn: (_, __) => expenseChartColor(context),
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.expenseAmount,
        data: data,
      ),
    ];

    final lineAndTextColor = Theme.of(context).brightness == Brightness.light
        ? charts.Color.black
        : charts.Color.white;

    return charts.BarChart(
      chartData,
      animate: false,
      barGroupingType: charts.BarGroupingType.grouped,
      // Everything below is to make it look good on light and dark themes.
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            color: lineAndTextColor,
          ),
          lineStyle: charts.LineStyleSpec(
            color: lineAndTextColor,
          ),
        ),
      ),

      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            color: lineAndTextColor,
          ),
          lineStyle: charts.LineStyleSpec(
            color: lineAndTextColor,
          ),
        ),
      ),
    );
  }
}
