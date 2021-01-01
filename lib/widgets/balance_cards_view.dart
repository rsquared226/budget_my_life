import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

import './balance_summary_card.dart';
import '../providers/filter.dart';
import '../providers/labels.dart';
import '../providers/transactions.dart';
import '../utils/custom_colors.dart';

// Used in DashboardScreen.

class BalanceCardsView extends StatefulWidget {
  @override
  _BalanceCardsViewState createState() => _BalanceCardsViewState();
}

class _BalanceCardsViewState extends State<BalanceCardsView> {
  PageController _pageController = PageController();

  void _moveTo(PageController pageController, int toPage) {
    pageController.animateToPage(
      toPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final filterData = Provider.of<Filter>(context);
    final labelFilter =
        Provider.of<Labels>(context).findById(filterData.labelId);
    final themeData = Theme.of(context);

    return Container(
      color: themeData.colorScheme.dashboardHeader,
      child: Column(
        children: <Widget>[
          SizedBox(
            // This is the height of the BalanceSummaryCard.
            height: 132,
            child: PageView(
              controller: _pageController,
              // If the user isn't filtering data, show the total balance. If the user is filtering data, show the total
              // for that specific label.
              children: <Widget>[
                // Monthly balance card.
                BalanceSummaryCard(
                  title: labelFilter == null
                      ? 'This Month\'s Balance'
                      : 'This Month\'s ' + labelFilter.title,
                  balance: labelFilter == null
                      ? transactionsData.monthlyBalance
                      : labelFilter.getLabelMonthAmountTotal(context),
                  onTap: () => _moveTo(_pageController, 1),
                ),
                // Total balance card.
                BalanceSummaryCard(
                  title: labelFilter == null
                      ? 'Lifetime Balance'
                      : 'Lifetime ' + labelFilter.title,
                  balance: labelFilter == null
                      ? transactionsData.balance
                      : labelFilter.getLabelAmountTotal(context),
                  onTap: () => _moveTo(_pageController, 0),
                ),
              ],
            ),
          ),
          ScrollingPageIndicator(
            dotSelectedColor: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : Colors.white60,
            dotColor: Theme.of(context).brightness == Brightness.light
                ? Colors.black26
                : Colors.white38,
            dotSelectedSize: 8.5,
            dotSpacing: 13,
            controller: _pageController,
            itemCount: 2,
          ),
        ],
      ),
    );
  }
}
