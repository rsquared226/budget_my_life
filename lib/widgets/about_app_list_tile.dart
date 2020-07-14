import 'package:flutter/material.dart';

class AboutAppListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      icon: const Icon(Icons.info),
      child: const Text('About'),
      applicationIcon: Image.asset(
        'assets/icon/launcher_icon.png',
        height: 75,
        width: 75,
      ),
      applicationLegalese: 'Licensed under GNU GPLv3',
      applicationVersion: 'v0.1.0',
      aboutBoxChildren: <Widget>[
        const SizedBox(height: 12),
        const Text('A beautiful and informative budgeting app'),
      ],
    );
  }
}
