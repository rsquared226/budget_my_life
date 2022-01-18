import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings.dart';
import '../utils/custom_colors.dart';

// Used in BalanceCardsView.

class BalanceSummaryCard extends StatelessWidget {
  final String title;
  final double balance;
  final void Function()? onTap;

  const BalanceSummaryCard({
    required this.title,
    required this.balance,
    this.onTap,
  });

  String formattedBalance(BuildContext context) {
    final currencySymbol =
        Provider.of<Settings>(context).displayedCurrencySymbol;
    var formattedBalance = '$currencySymbol${balance.abs().toStringAsFixed(2)}';
    if (balance < 0) {
      formattedBalance = '-' + formattedBalance;
    }
    return formattedBalance;
  }

  @override
  Widget build(BuildContext context) {
    final cardRadius = BorderRadius.circular(15);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: cardRadius,
      ),
      margin: const EdgeInsets.all(10),
      // To ensure the InkWell shows up.
      child: Ink(
        decoration: BoxDecoration(
          // To match Card's border radius.
          borderRadius: cardRadius,
          color: Theme.of(context).colorScheme.largeTypeColor(amount: balance),
        ),
        child: InkWell(
          highlightColor: Colors.black12,
          splashColor: Colors.black12,
          borderRadius: cardRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
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
                      color: Theme.of(context).colorScheme.onIncomeExpenseColor,
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
                      formattedBalance(context),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w300,
                        color:
                            Theme.of(context).colorScheme.onIncomeExpenseColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
