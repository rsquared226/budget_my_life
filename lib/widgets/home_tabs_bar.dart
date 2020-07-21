import 'package:flutter/material.dart';

// Used in HomeTabsScreen.

class HomeTabsBar extends StatelessWidget {
  final int pageIndex;
  final void Function(int newPageIndex) onPressed;

  const HomeTabsBar({
    @required this.pageIndex,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BottomNavigationBar(
      selectedItemColor: pageIndex == 0
          ? themeData.colorScheme.primary
          : themeData.colorScheme.onPrimary,
      unselectedItemColor:
          pageIndex == 0 ? themeData.textTheme.caption.color : Colors.white70,
      backgroundColor:
          pageIndex == 0 ? themeData.canvasColor : themeData.primaryColor,
      currentIndex: pageIndex,
      onTap: onPressed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          title: Text('Dashboard'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          title: Text('Insights'),
        ),
      ],
    );
  }
}
