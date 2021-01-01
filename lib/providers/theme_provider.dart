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
    // To make the ChoiceChips on EditLabelScreen legible.
    chipTheme: ChipThemeData.fromDefaults(
      secondaryColor: Colors.purpleAccent,
      brightness: Brightness.dark,
      labelStyle: ThemeData.dark().textTheme.bodyText1,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // This page transition looks better than the default.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );

  static final amoledTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    primaryColor: Color.fromARGB(255, 25, 25, 25),
    cardColor: Color.fromARGB(255, 25, 25, 25),
    dividerColor: Colors.grey[850],
    dialogBackgroundColor: Colors.grey[850],
    accentColor: Colors.purple.shade200,
    chipTheme: ChipThemeData.fromDefaults(
      secondaryColor: Colors.purpleAccent,
      brightness: Brightness.dark,
      labelStyle: ThemeData.dark().textTheme.bodyText1,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // This page transition looks better than the default.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}
