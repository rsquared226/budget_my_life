import 'package:flutter/material.dart';

import '../utils/db_helper.dart';
import '../models/label.dart';

class Labels with ChangeNotifier {
  // These are the id's of default labels. They cannot be deleted.
  static const otherIncomeId = 'l1';
  static const otherExpenseId = 'l2';

  var _items = <Label>[];

  List<Label> get items {
    return [..._items];
  }

  List<Label> get incomeLabels {
    return _items
        .where((label) => label.labelType == LabelType.INCOME)
        .toList();
  }

  List<Label> get expenseLabels {
    return _items
        .where((label) => label.labelType == LabelType.EXPENSE)
        .toList();
  }

  Label findById(String id) {
    return _items.firstWhere((label) => id == label.id, orElse: () => null);
  }

  void addLabel(Label label) {
    _items.add(label);
    notifyListeners();
    DBHelper.insertLabel(label);
  }

  void editLabel(Label editedLabel) {
    final editedIndex =
        _items.indexWhere((label) => editedLabel.id == label.id);

    if (editedIndex == null) {
      return;
    }
    _items[editedIndex] = editedLabel;
    notifyListeners();
    DBHelper.updateLabel(editedLabel);
  }

  void deleteLabel(String id) {
    if (id == otherExpenseId || id == otherIncomeId) {
      return;
    }
    _items.removeWhere((label) => label.id == id);
    notifyListeners();
    DBHelper.deleteLabel(id);
  }

  Future<void> fetchAndSetLabels() async {
    _items = await DBHelper.getLabels();

    // If the default labels weren't in storage, add them here.
    if (this.findById(otherIncomeId) == null ||
        this.findById(otherExpenseId) == null) {
      const starterLabels = const <Label>[
        // By adding both of these labels, the user can edit labels without a problem. If these aren't added to the db,
        // then the db will attempt to update a nonexistant label when edited.
        Label(
          id: otherIncomeId,
          title: 'Other income',
          color: Colors.blueGrey,
          labelType: LabelType.INCOME,
        ),
        Label(
          id: otherExpenseId,
          title: 'Other expense',
          color: Colors.grey,
          labelType: LabelType.EXPENSE,
        ),

        // Some nice starter labels. They can be edited/deleted with no problem.
        Label(
          id: 'l3',
          title: 'Job',
          color: Colors.orange,
          labelType: LabelType.INCOME,
        ),
        Label(
          id: 'l4',
          title: 'Groceries',
          color: Colors.green,
          labelType: LabelType.EXPENSE,
        ),
        Label(
          id: 'l5',
          title: 'Restaurants',
          color: Colors.amber,
          labelType: LabelType.EXPENSE,
        ),
        Label(
          id: 'l6',
          title: 'Luxury',
          color: Colors.deepPurple,
          labelType: LabelType.EXPENSE,
        ),
      ];

      starterLabels.forEach(
        (starterLabel) {
          _items.add(starterLabel);
          DBHelper.insertLabel(starterLabel);
        },
      );
    }
    notifyListeners();
  }
}
