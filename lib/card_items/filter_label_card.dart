import 'package:flutter/material.dart';

class FilterLabelCard extends StatelessWidget {
  final String title;
  final Color categoryColor;

  const FilterLabelCard({
    @required this.title,
    @required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          maxRadius: 10,
          backgroundColor: categoryColor,
        ),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }
}
