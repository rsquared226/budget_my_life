import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../widgets/app_drawer.dart';
import 'insights_screen.dart';
import './dashboard_screen.dart';
import '../widgets/home_tabs_bar.dart';

class HomeTabsScreen extends StatefulWidget {
  @override
  _HomeTabsScreenState createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  int _pageIndex = 0;

  final List<Widget> _pageList = <Widget>[
    DashboardScreen(),
    InsightsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget My Life'),
      ),
      drawer: AppDrawer(),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pageList[_pageIndex],
      ),
      bottomNavigationBar: HomeTabsBar(
        pageIndex: _pageIndex,
        onPressed: (newPageIndex) {
          setState(() {
            _pageIndex = newPageIndex;
          });
        },
      ),
    );
  }
}
