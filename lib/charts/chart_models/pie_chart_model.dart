import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChartModel {
  final String label;
  final double amount;
  final charts.Color color;

  PieChartModel({
    @required this.label,
    @required this.amount,
    @required Color color,
  }) : // Convert material color to chart color.
        this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
