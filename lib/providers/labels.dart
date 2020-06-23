import 'package:flutter/material.dart';

import '../models/label.dart';

// TODO: Decide which provider should do the heavy-lifting. Which model should include a list of id's for the other.
class Labels with ChangeNotifier {
  var _items = <Label>[
    Label(
      id: 'l1',
      title: 'Groceries',
      color: Colors.green,
      labelType: LabelType.EXPENSE,
    ),
    Label(
      id: 'l2',
      title: 'Luxury',
      color: Colors.purple,
      labelType: LabelType.EXPENSE,
    ),
    Label(
      id: 'l3',
      title: 'Education',
      color: Colors.orange,
      labelType: LabelType.EXPENSE,
    ),
  ];

  List<Label> get items {
    return [..._items];
  }
}
