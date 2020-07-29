import 'package:flutter/foundation.dart';

class TimeSeriesModel {
  final DateTime date;
  final double value;

  const TimeSeriesModel({
    @required this.date,
    @required this.value,
  });
}
