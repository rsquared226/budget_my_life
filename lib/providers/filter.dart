import 'package:flutter/material.dart';

// Used in HistoryScreen for filtering transactions there.

class Filter with ChangeNotifier {
  // When null it means nothing is being filtered.
  String _labelId;

  String get labelId => _labelId;

  set labelId(String labelId) {
    _labelId = labelId;
    notifyListeners();
  }
}
