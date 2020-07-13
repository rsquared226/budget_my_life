import 'package:flutter/material.dart';

// Used in HistoryScreen for filtering transactions there.

class Filter with ChangeNotifier {
  String _labelId;

  String get labelId {
    return _labelId;
  }

  set labelId(String labelId) {
    _labelId = labelId;
    notifyListeners();
  }
}
