import 'package:flutter/material.dart';

import '../screens/edit_labels_screen.dart';
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
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('History'),
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
          AboutAppListTile(),
        ],
      ),
    );
  }
}
