import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/labels.dart';

// Used in HistoryScreen.

class LabelFilterDropdown extends StatelessWidget {
  Widget buildFilterLabelCard(Color color, String title) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          maxRadius: 10,
          backgroundColor: color,
        ),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = Provider.of<Labels>(context).items;

    // Idea: have the dropdown highlighted when an actual filter is selected.
    return DropdownButton<String>(
      icon: const Icon(Icons.filter_list),
      items: [
        DropdownMenuItem(
          value: null,
          child: buildFilterLabelCard(
            Colors.transparent,
            'All',
          ),
        ),
        ...labels.map(
          (label) {
            return DropdownMenuItem(
              value: label.id,
              child: buildFilterLabelCard(
                label.color,
                label.title,
              ),
            );
          },
        ).toList()
      ],
      onChanged: (newVal) {},
    );
  }
}
