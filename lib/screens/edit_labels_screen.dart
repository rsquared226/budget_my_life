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

  Widget buildAddLabelButton(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: RaisedButton.icon(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () => addLabel(context),
              icon: const Icon(Icons.add),
              label: const Text('ADD LABEL'),
            ),
          ),
        ],
      ),
    );
  }

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
              deleteTransaction: () async {
                // Can't let the user delete the default labels. If this happens, the whole app could crash.
                if (labels[index].id == Labels.otherIncomeId ||
                    labels[index].id == Labels.otherExpenseId) {
                  await showCannotDeleteOtherLabelDialog(context);
                  return;
                }
                if (await confirmLabelDeletion(context)) {
                  Provider.of<Labels>(context, listen: false)
                      .deleteLabel(labels[index].id);
                }
              },
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

  Future<bool> confirmLabelDeletion(BuildContext context) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete label?'),
          content: const Text('Are you sure you want to delete this label?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCEL'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'DELETE',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
    // If the user clicks out of the dialog to dismiss, the result will be null. We will assume they don't want to
    // delete the transaction if they do that.
    return confirmDelete ?? false;
  }

  Future<void> showCannotDeleteOtherLabelDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cannot delete default label'),
          content: const Text('The default labels cannot be deleted.'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('GOT IT'),
            )
          ],
        );
      },
    );
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
          buildAddLabelButton(context),
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
