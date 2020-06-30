import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class EditLabelsScreen extends StatelessWidget {
  static const routeName = '/edit-labels';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Labels'),
      ),
      drawer: AppDrawer(),
    );
  }
}
