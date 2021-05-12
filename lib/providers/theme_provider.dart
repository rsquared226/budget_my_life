import 'package:budget_my_life/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Colors.white),
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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Colors.white),
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

  Future<void> fetchAndSetTheme() async {
    final settingsMap = await DBHelper.getSettingsMap();

    switch (settingsMap['theme']) {
      case 0:
        _themeType = ThemeType.Light;
        break;
      case 1:
        _themeType = ThemeType.Dark;
        break;
      case 2:
        _themeType = ThemeType.Amoled;
        break;
      // If there's no value, default to light or dark theme depending on
      // system theme.
      default:
        final brightness = SchedulerBinding.instance.window.platformBrightness;
        _themeType =
            brightness == Brightness.light ? ThemeType.Light : ThemeType.Dark;
        DBHelper.updateSettings(
            {'theme': brightness == Brightness.light ? 0 : 1});
        break;
    }
    notifyListeners();
  }

  set themeType(ThemeType themeType) {
    _themeType = themeType;
    DBHelper.updateSettings({'theme': themeType.index});
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
        return lightTheme;
    }
  }
}
