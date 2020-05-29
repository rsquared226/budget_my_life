import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import './add_transaction_screen.dart';
import './graphs_screen.dart';
import './history_screen.dart';

// Need this because the built-in FloatingActionButton widget isn't being used. A custom one is for the animation.
const _fabDimension = 56.0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  final List<Widget> _pageList = <Widget>[
    HistoryScreen(),
    GraphsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget My Life'),
      ),
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
      floatingActionButton: OpenContainer(
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: Theme.of(context).primaryColor,
        closedBuilder: (context, _) {
          return SizedBox(
            height: _fabDimension,
            width: _fabDimension,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
        },
        openBuilder: (_, __) {
          return AddTransactionScreen();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (newPageIndex) {
          setState(() {
            _pageIndex = newPageIndex;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Graphs'),
          ),
        ],
      ),
    );
  }
}
