import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TransactionDetailChartModel {
  final String label;
  final double amount;
  final charts.Color color;

  TransactionDetailChartModel({
    @required this.label,
    @required this.amount,
    @required Color color,
  }) : // Convert material color to chart color.
        this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
