import 'package:flutter/material.dart';

import '../screens/edit_labels_screen.dart';
import '../screens/onboarding.dart';
import './about_app_list_tile.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Theme.of(context).primaryColor,
            // SafeArea so it doesn't take the notification bar in account for centering vertically.
            child: SafeArea(
              child: Center(
                child: Text(
                  'Budget your life with ease.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Dashboard'),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              '/',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Labels'),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              EditLabelsScreen.routeName,
            ),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Onboarding(openedFromDrawer: true),
              ),
            ),
          ),
          AboutAppListTile(),
        ],
      ),
    );
  }
}
