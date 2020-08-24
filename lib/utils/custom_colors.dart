import 'package:flutter/material.dart';

import '../models/label.dart';

class CustomColors {
  // The secondary colors are used in graphs.

  static final incomeColor = Colors.green.shade800;
  static final secondaryIncomeColor = Colors.green.shade200;

  static final expenseColor = Colors.pink.shade900;
  static final secondaryExpenseColor = Colors.red.shade200;

  static final onIncomeExpenseColor = Colors.white;

  // Takes in the amount and returns the income or expense color accordingly.
  static Color transactionTypeColor(double amount) {
    return (amount != null && amount >= 0) ? incomeColor : expenseColor;
  }

  // Same method above but for labelTypes.
  static Color labelTypeColor(LabelType labelType) {
    return (labelType == LabelType.INCOME) ? incomeColor : expenseColor;
  }

  static Color secondaryTransactionTypeColor(double amount) {
    return (amount != null && amount >= 0)
        ? secondaryIncomeColor
        : secondaryExpenseColor;
  }
}
