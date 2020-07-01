import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/label.dart';
import '../providers/labels.dart';
import '../widgets/app_drawer.dart';

class EditLabelsScreen extends StatelessWidget {
  static const routeName = '/edit-labels';

  List<Widget> buildSliverWidget(String headerText, List<Label> labels) {
    return [
      SliverList(
        delegate: SliverChildListDelegate.fixed(
          <Widget>[
            Text(headerText),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Text(labels[index].title);
          },
          childCount: labels.length,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final labelsData = Provider.of<Labels>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Labels'),
      ),
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          ...buildSliverWidget(
            'Income Labels',
            labelsData.incomeLabels,
          ),
          ...buildSliverWidget(
            'Expense Labels',
            labelsData.expenseLabels,
          ),
        ],
      ),
    );
  }
}
