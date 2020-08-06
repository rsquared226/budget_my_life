import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/balance_history_model.dart';
import '../../utils/custom_colors.dart';

class TimeSeriesBase extends StatelessWidget {
  final String id;
  final List<BalanceHistoryModel> data;

  TimeSeriesBase({
    @required this.id,
    @required Color color,
    @required this.data,
  });

  List<charts.Series<BalanceHistoryModel, String>> get chartData {
    return [
      charts.Series<BalanceHistoryModel, String>(
        id: id,
        colorFn: (_, __) => incomeChartColor,
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.incomeAmount,
        data: data,
      ),
      charts.Series<BalanceHistoryModel, String>(
        id: id,
        colorFn: (_, __) => expenseChartColor,
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.expenseAmount,
        data: data,
      ),
    ];
  }

  charts.Color get incomeChartColor =>
      convertToChartColor(CustomColors.incomeColor);

  charts.Color get expenseChartColor =>
      convertToChartColor(CustomColors.expenseColor);

  charts.Color convertToChartColor(Color color) => charts.Color(
        r: color.red,
        g: color.green,
        b: color.blue,
        a: color.alpha,
      );

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      chartData,
      animate: false,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
}
