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
    return items
        .where((label) => label.labelType == LabelType.EXPENSE)
        .toList();
  }

  List<Label> get expenseLabels {
    return items.where((label) => label.labelType == LabelType.INCOME).toList();
  }

  Label findById(String id) {
    return items.firstWhere((label) => id == label.id);
  }
}
