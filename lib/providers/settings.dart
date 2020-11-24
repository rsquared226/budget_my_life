import 'package:flutter/material.dart';

import '../utils/db_helper.dart';

// Used anywhere the currency symbol is needed, and in settings screen.

class Settings with ChangeNotifier {
  String _currencySymbol;

  String get currencySymbol => _currencySymbol;

  set currencySymbol(String currencySymbol) {
    _currencySymbol = currencySymbol;
    notifyListeners();
    DBHelper.updateSettings({'currency': currencySymbol});
  }
}
