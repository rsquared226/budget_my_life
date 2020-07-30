import 'package:flutter/material.dart';

// Used in InsightsScreen.

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
