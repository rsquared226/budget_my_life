import 'package:flutter/material.dart';

// Used in InsightsScreen.

// week and month mean the beginning of the week and month.
// For week it's Sunday.
// For month it's the first day of the month.
enum Range {
  week,
  month,
  lifetime,
}

class InsightsRange with ChangeNotifier {
  Range _range = Range.month;

  Range get range => _range;

  set range(Range range) {
    _range = range;
    notifyListeners();
  }
}
