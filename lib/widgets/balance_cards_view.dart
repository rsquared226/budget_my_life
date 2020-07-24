import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final filterData = Provider.of<Filter>(context);
    final labelFilter =
        Provider.of<Labels>(context).findById(filterData.labelId);

    // If the user isn't filtering data, show the total balance. If the user is filtering data, show the total for that
    // specific label.
    return BalanceSummaryCard(
      title: labelFilter == null ? 'Balance' : labelFilter.title + ' total',
      balance: labelFilter == null
          ? transactionsData.balance
          : labelFilter.getLabelTotal(context),
    );
  }
}
