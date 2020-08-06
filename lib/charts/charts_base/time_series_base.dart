import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/balance_history_model.dart';

class TimeSeriesBase extends StatelessWidget {
  final String id;
  final charts.Color color;
  final List<BalanceHistoryModel> data;

  TimeSeriesBase({
    @required this.id,
    @required Color color,
    @required this.data,
  }) : // Convert material color to chart color.
        this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);

  List<charts.Series<BalanceHistoryModel, String>> get chartData {
    return [
      charts.Series<BalanceHistoryModel, String>(
        id: id,
        colorFn: (_, __) => color,
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.incomeAmount,
        data: data,
      ),
      charts.Series<BalanceHistoryModel, String>(
        id: id,
        colorFn: (_, __) => color,
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.expenseAmount,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      chartData,
      animate: false,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
}
