import 'package:flutter/material.dart';

import '../models/label.dart';
import '../charts/chart_widgets/labels_pie_chart.dart';

// This screen is a screen under home_screen

class GraphsScreen extends StatelessWidget {
  static Widget _buildGraphContainer(Widget graph) {
    return Center(
      child: SizedBox(
        height: 275,
        child: graph,
      ),
    );
  }

  final graphScreens = <Widget>[
    _buildGraphContainer(
      LabelsPieChart(labelType: LabelType.INCOME),
    ),
    _buildGraphContainer(
      LabelsPieChart(labelType: LabelType.EXPENSE),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (_, index) {
        return graphScreens[index];
      },
      itemCount: graphScreens.length,
    );
  }
}
