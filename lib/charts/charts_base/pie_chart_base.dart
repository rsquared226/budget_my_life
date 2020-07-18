import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/pie_chart_model.dart';

// This is used in TransactionDetailsScreen.

class PieChartBase extends StatelessWidget {
  final String id;
  final List<PieChartModel> pieData;

  const PieChartBase({
    @required this.id,
    @required this.pieData,
  });

  List<charts.Series<PieChartModel, String>> get chartData {
    return [
      charts.Series(
        id: id,
        domainFn: (PieChartModel data, _) => data.label,
        measureFn: (PieChartModel data, _) => data.amount,
        colorFn: (PieChartModel data, _) => data.color,
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
