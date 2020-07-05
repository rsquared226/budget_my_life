import 'package:flutter/material.dart';

import '../models/label.dart';

class Labels with ChangeNotifier {
  static const otherIncomeId = 'l1';
  static const otherExpenseId = 'l2';

  var _items = <Label>[
    Label(
      id: otherIncomeId,
      title: 'Other income',
      color: Colors.blueGrey,
      labelType: LabelType.INCOME,
    ),
    Label(
      id: otherExpenseId,
      title: 'Other expense',
      color: Colors.orange,
      labelType: LabelType.EXPENSE,
    ),
    Label(
      id: 'l3',
      title: 'Groceries',
      color: Colors.green,
      labelType: LabelType.EXPENSE,
    ),
    Label(
      id: 'l4',
      title: 'Luxury',
      color: Colors.purple,
      labelType: LabelType.EXPENSE,
    ),
    Label(
      id: 'l5',
      title: 'Education',
      color: Colors.orange,
      labelType: LabelType.EXPENSE,
    ),
  ];

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
    return _items.firstWhere((label) => id == label.id);
  }

  void addLabel(Label label) {
    _items.add(label);
    notifyListeners();
  }

  void editLabel(Label editedLabel) {
    final editedIndex =
        _items.indexWhere((label) => editedLabel.id == label.id);

    if (editedIndex == null) {
      return;
    }
    _items[editedIndex] = editedLabel;
    notifyListeners();
  }

  void deleteLabel(String id) {
    _items.removeWhere((label) => label.id == id);
    notifyListeners();
  }
}
