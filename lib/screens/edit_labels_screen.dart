import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card_items/edit_labels_card.dart';
import '../models/label.dart';
import '../providers/labels.dart';
import './edit_label_screen.dart';
import '../widgets/app_drawer.dart';

// This is navigated to from the drawer of the app.

class EditLabelsScreen extends StatelessWidget {
  static const routeName = '/edit-labels';

  List<Widget> _buildSliverHeaderList(
    BuildContext context,
    String headerText,
    List<Label> labels,
  ) {
    return [
      SliverList(
        delegate: SliverChildListDelegate.fixed(
          <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 5, 0),
              child: Text(
                headerText,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return EditLabelsCard(
              label: labels[index],
              editTransaction: () => editLabel(
                context,
                labels[index].id,
              ),
            );
          },
          childCount: labels.length,
        ),
      ),
    ];
  }

  void addLabel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditLabelScreen()),
    );
  }

  void editLabel(BuildContext context, String labelId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditLabelScreen(
          editLabelId: labelId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelsData = Provider.of<Labels>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Labels'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => addLabel(context),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          ..._buildSliverHeaderList(
            context,
            'Income Labels',
            labelsData.incomeLabels,
          ),
          ..._buildSliverHeaderList(
            context,
            'Expense Labels',
            labelsData.expenseLabels,
          ),
        ],
      ),
    );
  }
}
