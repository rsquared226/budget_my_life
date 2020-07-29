import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/time_series_model.dart';

class TimeSeriesBase extends StatelessWidget {
  final String id;
  final charts.Color color;
  final List<TimeSeriesModel> data;

  TimeSeriesBase({
    @required this.id,
    @required Color color,
    @required this.data,
  }) : // Convert material color to chart color.
        this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);

  List<charts.Series<TimeSeriesModel, DateTime>> get chartData {
    return [
      charts.Series<TimeSeriesModel, DateTime>(
        id: id,
        colorFn: (_, __) => color,
        domainFn: (data, _) => data.date,
        measureFn: (data, _) => data.value,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      chartData,
      animate: false,
    );
  }
}
