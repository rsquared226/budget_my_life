import 'package:flutter/material.dart';

import '../models/label.dart';
import '../charts/chart_widgets/labels_pie_chart.dart';
import '../utils/custom_colors.dart';
import '../widgets/chart_container.dart';

// This screen is a screen under home_screen

class GraphsScreen extends StatelessWidget {
  final graphScreens = <Widget>[
    ChartContainer(
      chart: LabelsPieChart(labelType: LabelType.INCOME),
      color: CustomColors.incomeColor,
    ),
    ChartContainer(
      chart: LabelsPieChart(labelType: LabelType.EXPENSE),
      color: CustomColors.expenseColor,
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
