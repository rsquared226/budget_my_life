import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter.dart';
import '../widgets/balance_cards_view.dart';
import '../widgets/dashboard_list_header.dart';
import '../widgets/dashboard_screen_fab.dart';
import '../widgets/transactions_list.dart';

// This screen is a tab under home_screen.
class DashboardScreen extends StatelessWidget {
  SliverList buildSliverBalanceCard() {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          BalanceCardsView(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DashboardScreenFAB(),
      body: ChangeNotifierProvider(
        create: (_) => Filter(),
        // Fetch and set data in this screen because it is the first screen the user sees.
        child: CustomScrollView(
          slivers: <Widget>[
            buildSliverBalanceCard(),
            DashboardListHeader(),
            TransactionsList(),
          ],
        ),
      ),
    );
  }
}
