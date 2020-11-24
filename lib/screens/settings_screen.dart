import 'package:flutter/material.dart';

import '../providers/settings.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('test'),
      ),
    );
  }
}
