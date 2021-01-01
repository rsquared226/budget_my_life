import 'package:flutter/material.dart';

import '../models/label.dart';

extension CustomColors on ColorScheme {
  // The secondary colors are used in graphs.

  // These are swapped when the theme is dark (for the most part).
  static final _internalIncomeColor = Colors.green.shade800;
  static final _internalSecondaryIncomeColor = Colors.green.shade200;
  static final _internalDarkIncomeColor = Color.fromARGB(255, 53, 124, 57);
  static final _internalDarkLargeIncomeColor = Color.fromARGB(255, 31, 81, 38);

  static final _internalExpenseColor = Colors.pink.shade900;
  static final _internalSecondaryExpenseColor = Colors.red.shade400;
  static final _internalDarkExpenseColor = Color.fromARGB(255, 163, 70, 69);
  static final _internalDarkLargeExpenseColor = Color.fromARGB(255, 86, 29, 30);

  Color get incomeColor =>
      _isLight ? _internalIncomeColor : _internalDarkIncomeColor;

  Color get secondaryIncomeColor => _internalSecondaryIncomeColor;

  Color get expenseColor =>
      _isLight ? _internalExpenseColor : _internalDarkExpenseColor;

  Color get secondaryExpenseColor => _internalSecondaryExpenseColor;

  Color get onIncomeExpenseColor =>
      _isLight ? Colors.white : Colors.grey.shade200;

  // Takes in the amount and returns the income or expense color accordingly.
  Color transactionTypeColor(double amount) {
    return (amount != null && amount >= 0) ? incomeColor : expenseColor;
  }

  // Same method above but for labelTypes.
  Color labelTypeColor(LabelType labelType) {
    return (labelType == LabelType.INCOME) ? incomeColor : expenseColor;
  }

  // On dark mode, the default income/expense colors look wrong for large objects.
  // These contain colors that look nice on dark mode.
  // Used on balance card and edit transaction header.
  // Only one of the parameters is needed.
  Color largeTypeColor({double amount, LabelType labelType}) {
    if (amount != null) {
      if (_isLight) {
        return (amount >= 0) ? _internalIncomeColor : _internalExpenseColor;
      }
      return (amount >= 0)
          ? _internalDarkLargeIncomeColor
          : _internalDarkLargeExpenseColor;
    }

    if (_isLight) {
      return (labelType == LabelType.INCOME)
          ? _internalIncomeColor
          : _internalExpenseColor;
    }

    return (labelType == LabelType.INCOME)
        ? _internalDarkLargeIncomeColor
        : _internalDarkLargeExpenseColor;
  }

  Color secondaryTransactionTypeColor(double amount) {
    return (amount != null && amount >= 0)
        ? secondaryIncomeColor
        : secondaryExpenseColor;
  }

  Color get dashboardHeader {
    // TODO: If it's light/dark, themeData.brightness == Brightness.light ? themeData.colorScheme.surface : themeData.canvasColor, If it's amoled
    return Color.fromARGB(255, 15, 15, 15);
  }

  Color get transactionCards {
    // TODO: If it's light/dark, Theme.of(context).cardColor. If it's AMOLED, Colors.black
    return Colors.black;
  }

  // Small internal helper just to shorten code when checking for light or dark theme.
  bool get _isLight => brightness == Brightness.light;
}
