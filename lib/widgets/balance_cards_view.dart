import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

import './balance_summary_card.dart';
import '../providers/filter.dart';
import '../providers/labels.dart';
import '../providers/transactions.dart';

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
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final filterData = Provider.of<Filter>(context);
    final labelFilter =
        Provider.of<Labels>(context).findById(filterData.labelId);

    return Column(
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
                    : labelFilter.getLabelMonthTotal(context),
                onTap: () => _moveTo(_pageController, 1),
              ),
              // Total balance card.
              BalanceSummaryCard(
                title: labelFilter == null
                    ? 'Lifetime Balance'
                    : 'Lifetime ' + labelFilter.title,
                balance: labelFilter == null
                    ? transactionsData.balance
                    : labelFilter.getLabelTotal(context),
                onTap: () => _moveTo(_pageController, 0),
              ),
            ],
          ),
        ),
        ScrollingPageIndicator(
          dotSelectedColor: Colors.grey,
          dotColor: Colors.black26,
          dotSelectedSize: 8.5,
          dotSpacing: 13,
          controller: _pageController,
          itemCount: 2,
        ),
      ],
    );
  }
}
