import 'package:flutter/material.dart';

import '../models/label.dart';
import '../charts/chart_widgets/labels_pie_chart.dart';

// This screen is a screen under home_screen

class GraphsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const LabelsPieChart(labelType: LabelType.INCOME),
    );
  }
}
