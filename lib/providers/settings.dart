import 'package:flutter/material.dart';

import '../utils/db_helper.dart';

// Used anywhere the currency symbol is needed, and in settings screen.

class Settings with ChangeNotifier {
  String _currencySymbol;
  bool _showCurrency;

  // TODO: Check if this needs defaults in the constructor.

  Future<void> fetchAndSetSettings() async {
    final settingsMap = await DBHelper.getSettingsMap();
    _currencySymbol = settingsMap['currency'];
    _showCurrency = settingsMap['showCurrency'] == 1;
    notifyListeners();
  }

  String get currencySymbol => _currencySymbol;
  bool get showCurrency => _showCurrency;

  set currencySymbol(String currencySymbol) {
    _currencySymbol = currencySymbol;
    notifyListeners();
    DBHelper.updateSettings({'currency': currencySymbol});
  }

  set showCurrency(bool showCurrency) {
    _showCurrency = showCurrency;
    notifyListeners();
    DBHelper.updateSettings({'showCurrency': showCurrency ? 1 : 0});
  }
}
