import 'package:flutter/material.dart';

// Used in HomeTabsScreen.

class HomeTabsBar extends StatelessWidget {
  final int pageIndex;
  final void Function(int newPageIndex) onPressed;

  const HomeTabsBar({
    @required this.pageIndex,
    @required this.onPressed,
  });

  Color getSelectedItemColor(ThemeData themeData, int pageIndex) {
    if (themeData.brightness == Brightness.light) {
      // 2 different colors because bottom tabs background change color in light
      // mode.
      return pageIndex == 0
          ? themeData.colorScheme.primary
          : themeData.colorScheme.onPrimary;
    }
    // Bottom tabs background doesn't change in dark theme.
    return themeData.colorScheme.onPrimary;
  }

  Color getUnselectedItemColor(ThemeData themeData, int pageIndex) {
    if (themeData.brightness == Brightness.light) {
      return pageIndex == 0
          ? themeData.textTheme.caption.color
          : Colors.white70;
    }
    return themeData.textTheme.caption.color;
  }

  Color getBackgroundColor(ThemeData themeData, int pageIndex) {
    if (themeData.brightness == Brightness.light) {
      return pageIndex == 0 ? themeData.canvasColor : themeData.primaryColor;
    }

    // Make it match the appbar if it's dark theme.
    return themeData.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BottomNavigationBar(
      selectedItemColor: getSelectedItemColor(themeData, pageIndex),
      unselectedItemColor: getUnselectedItemColor(themeData, pageIndex),
      backgroundColor: getBackgroundColor(themeData, pageIndex),
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
