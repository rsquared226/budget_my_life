import 'package:flutter/material.dart';

// Used in InsightsScreen.

enum Range {
  sevenDays,
  thirtyDays,
  lifetime,
}

class InsightsRange with ChangeNotifier {
  Range _range = Range.thirtyDays;

  Range get range => _range;

  set range(Range range) {
    _range = range;
    notifyListeners();
  }
}
