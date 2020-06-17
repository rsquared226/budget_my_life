import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TransactionDetailChartModel {
  final String label;
  final double amount;
  final charts.Color color;

  const TransactionDetailChartModel({
    @required this.label,
    @required this.amount,
    @required this.color,
  });
}
