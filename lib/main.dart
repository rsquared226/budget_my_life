import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/labels.dart';
import './providers/transactions.dart';
import './providers/settings.dart';
import './providers/theme_provider.dart';
import './screens/home_tabs_screen.dart';
import './screens/edit_labels_screen.dart';
import './screens/settings_screen.dart';
import './screens/onboarding.dart';
import './utils/db_helper.dart';

Future<void> main() async {
  // Add custom font license.
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Needed for onboarding.
  WidgetsFlutterBinding.ensureInitialized();
  final isOnboarded = await DBHelper.isOnboarded();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Settings(),
        ),
        ChangeNotifierProvider(
          create: (_) => Transactions(),
        ),
        ChangeNotifierProvider(
          create: (_) => Labels(),
        ),
      ],
      builder: (context, _) => MyApp(isOnboarded: isOnboarded),
    ),
  );
}

Future<void> fetchAndSetData(BuildContext context) async {
  // https://alvinalexander.com/dart/how-run-multiple-dart-futures-in-parallel/
  // TODO: Move this above so it doesn't run multiple times? run when app runs and pass in future as a parameter to home tabs screen?
  // https://stackoverflow.com/a/59623359/4907741
  await Future.wait<void>([
    Provider.of<Settings>(context, listen: false).fetchAndSetSettings(),
    Provider.of<Labels>(context, listen: false).fetchAndSetLabels(),
    Provider.of<Transactions>(context, listen: false).fetchAndSetTransactions(),
    Provider.of<ThemeProvider>(context, listen: false).fetchAndSetTheme(),
  ]);
}

class MyApp extends StatelessWidget {
  final bool isOnboarded;

  const MyApp({
    @required this.isOnboarded,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAndSetData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            home: Scaffold(),
          );
        }
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) => MaterialApp(
            title: 'Budget My Life',
            theme: themeProvider.themeData,
            initialRoute: isOnboarded ? '/' : Onboarding.routeName,
            home: HomeTabsScreen(),
            routes: {
              EditLabelsScreen.routeName: (_) => EditLabelsScreen(),
              SettingsScreen.routeName: (_) => SettingsScreen(),
              Onboarding.routeName: (_) => Onboarding()
            },
          ),
        );
      },
    );
  }
}
