import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/labels.dart';
import './providers/transactions.dart';
import './screens/home_tabs_screen.dart';
import './screens/edit_labels_screen.dart';
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
  // TODO: remove this print statement.
  print('isOnboarded:' + isOnboarded.toString());

  runApp(MyApp(isOnboarded: isOnboarded));
}

class MyApp extends StatelessWidget {
  final bool isOnboarded;

  const MyApp({
    @required this.isOnboarded,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Transactions(),
        ),
        ChangeNotifierProvider(
          create: (_) => Labels(),
        ),
      ],
      child: MaterialApp(
        title: 'Budget My Life',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepPurpleAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // This page transition looks better than the default.
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        home: HomeTabsScreen(),
        routes: {
          EditLabelsScreen.routeName: (_) => EditLabelsScreen(),
        },
      ),
    );
  }
}
