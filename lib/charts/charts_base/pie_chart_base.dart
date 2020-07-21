import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/pie_chart_model.dart';

// This is used in TransactionDetailsScreen.

class PieChartBase extends StatelessWidget {
  final String id;
  final bool animated;
  final List<PieChartModel> pieData;
  final bool showArcLabels;
  final charts.ArcLabelPosition arcLabelPosition;
  final List<charts.ChartBehavior> behaviors;

  const PieChartBase({
    @required this.id,
    @required this.animated,
    @required this.pieData,
    @required this.showArcLabels,
    this.arcLabelPosition = charts.ArcLabelPosition.auto,
    this.behaviors,
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
      animate: animated,
      behaviors: behaviors,
      // if defaultRenderer is null, no arc labels will show.
      defaultRenderer: showArcLabels
          ? charts.ArcRendererConfig(
              arcRendererDecorators: [
                charts.ArcLabelDecorator(
                  labelPosition: arcLabelPosition,
                ),
              ],
            )
          : null,
    );
  }
}
