import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/transactions.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (_) => Transactions(),
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
        home: HomeScreen(),
      ),
    );
  }
}
