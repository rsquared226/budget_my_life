import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

// Used in BalanceCardsView.

class BalanceSummaryCard extends StatelessWidget {
  final String title;
  final double balance;

  const BalanceSummaryCard({
    @required this.title,
    @required this.balance,
  });

  String get formattedBalance {
    var formattedBalance = '\$${balance.abs().toStringAsFixed(2)}';
    if (balance < 0) {
      formattedBalance = '-' + formattedBalance;
    }
    return formattedBalance;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          // To match Card's border radius.
          borderRadius: BorderRadius.circular(4),
          color: CustomColors.transactionTypeColor(balance),
        ),
        child: Column(
          children: <Widget>[
            // Must surround text with container so it will take up space to align left.
            Container(
              width: double.infinity,
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: CustomColors.onIncomeExpenseColor,
                ),
              ),
            ),
            // Must surround text with container so it will take up space to align right.
            Container(
              // FittedBox would take up too much height otherwise.
              height: 80,
              width: double.infinity,
              child: FittedBox(
                alignment: Alignment.bottomRight,
                // Only shrink the fontSize if needed, but don't grow it.
                fit: BoxFit.scaleDown,
                child: Text(
                  formattedBalance,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                    color: CustomColors.onIncomeExpenseColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
