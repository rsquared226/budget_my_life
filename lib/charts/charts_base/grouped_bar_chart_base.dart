import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/transaction_history_model.dart';
import '../../utils/custom_colors.dart';

class GroupedBarChartBase extends StatelessWidget {
  final String id;
  final List<TransactionHistoryModel> data;

  GroupedBarChartBase({
    @required this.id,
    @required Color color,
    @required this.data,
  });

  List<charts.Series<TransactionHistoryModel, String>> get chartData {
    return [
      charts.Series<TransactionHistoryModel, String>(
        id: id,
        colorFn: (_, __) => incomeChartColor,
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.incomeAmount,
        data: data,
      ),
      charts.Series<TransactionHistoryModel, String>(
        id: id,
        colorFn: (_, __) => expenseChartColor,
        domainFn: (data, _) => data.dateString,
        measureFn: (data, _) => data.expenseAmount,
        data: data,
      ),
    ];
  }

  charts.Color get incomeChartColor =>
      convertToChartColor(CustomColors.incomeColor.withOpacity(.9));

  charts.Color get expenseChartColor =>
      convertToChartColor(CustomColors.expenseColor.withOpacity(.9));

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
