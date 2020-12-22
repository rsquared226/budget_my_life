import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    accentColor: Colors.deepPurpleAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // This page transition looks better than the default.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    accentColor: Colors.purple.shade200,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // This page transition looks better than the default.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}
