import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter.dart';
import '../providers/labels.dart';

// Used in DashboardListHeader.

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
    final filterData = Provider.of<Filter>(context);

    return DropdownButton<String>(
      icon: const Icon(Icons.filter_list),
      value: filterData.labelId,
      // So it's easy to tell when the list is actually filtering.
      underline: Container(
        height: filterData.labelId == null ? 1 : 2,
        color: filterData.labelId == null
            ? Colors.grey[300]
            : Theme.of(context).primaryColor,
      ),
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
      onChanged: (newFilterId) {
        filterData.labelId = newFilterId;
      },
    );
  }
}
