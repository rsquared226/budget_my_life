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
  await Future.wait<void>([
    Provider.of<ThemeProvider>(context, listen: false).fetchAndSetTheme(),
    Provider.of<Settings>(context, listen: false).fetchAndSetSettings(),
    Provider.of<Labels>(context, listen: false).fetchAndSetLabels(),
    Provider.of<Transactions>(context, listen: false).fetchAndSetTransactions(),
  ]);
}

class MyApp extends StatefulWidget {
  final bool isOnboarded;

  const MyApp({
    required this.isOnboarded,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This determines the progress of data being read from storage.
  Future<void>? dataFetchFuture;

  @override
  void initState() {
    super.initState();
    dataFetchFuture = fetchAndSetData(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataFetchFuture,
      builder: (context, snapshot) {
        // Temporary loading screen until all data is loaded.
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) => MaterialApp(
            title: 'Budget My Life',
            theme: themeProvider.themeData,
            initialRoute: widget.isOnboarded ? '/' : Onboarding.routeName,
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
