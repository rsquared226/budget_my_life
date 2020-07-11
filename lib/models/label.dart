import 'package:flutter/material.dart';

enum LabelType { INCOME, EXPENSE }

class Label {
  final String id;
  final String title;
  final Color color;
  final LabelType labelType;

  const Label({
    @required this.id,
    @required this.title,
    @required this.color,
    @required this.labelType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color.value,
      'labelType': labelType.index,
    };
  }

  static Label fromMap(Map<String, dynamic> map) {
    return Label(
      id: map['id'],
      title: map['title'],
      color: Color(map['color']),
      labelType: LabelType.values[map['labelType']],
    );
  }
}
