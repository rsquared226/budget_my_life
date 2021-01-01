import 'package:flutter/material.dart';

enum ThemeType { Light, Dark, Amoled }

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

  ThemeType _themeType;

  ThemeProvider() {
    // TODO: db read stuff here.
    _themeType = ThemeType.Light;
    notifyListeners();
  }

  set themeType(ThemeType themeType) {
    _themeType = themeType;
    // TODO: db write stuff here.
    notifyListeners();
  }

  ThemeType get themeType => _themeType;

  ThemeData get themeData {
    switch (_themeType) {
      case ThemeType.Dark:
        return darkTheme;
      case ThemeType.Amoled:
        return amoledTheme;
      // Fallback onto light theme if something goes wrong
      default:
        // TODO: remove this.
        print('THEME WENT WRONG SOMEWHERE');
        return lightTheme;
    }
  }
}
