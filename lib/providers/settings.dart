import 'package:flutter/material.dart';

import '../utils/db_helper.dart';

// Used anywhere the currency symbol is needed, and in settings screen.

class Settings with ChangeNotifier {
  String _currencySymbol;
  bool _showCurrency;

  Future<void> fetchAndSetSettings() async {
    final settingsMap = await DBHelper.getSettingsMap();
    _currencySymbol = settingsMap['currency'];
    _showCurrency = settingsMap['showCurrency'] == 1;
    notifyListeners();
  }

  String get currencySymbol {
    // If we're showing the currency symbol, return a currency symbol.
    // Otherwise, just return an empty string. It's easier to deal with that way.
    if (_showCurrency) {
      return _currencySymbol;
    }
    return '';
  }

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
