import 'package:flutter/material.dart';

class CustomColors {
  static final incomeColor = Colors.green.shade800;
  static final expenseColor = Colors.pink.shade900;
  static final onIncomeExpenseColor = Colors.white;

  // Takes in the amount and returns the income or expense color accordingly.
  static Color transactionTypeColor(double amount) {
    return (amount != null && amount > 0) ? incomeColor : expenseColor;
  }
}
