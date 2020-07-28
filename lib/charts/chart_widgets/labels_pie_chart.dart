import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../chart_models/pie_chart_model.dart';
import '../charts_base/pie_chart_base.dart';
import '../../models/label.dart';
import '../../providers/insights_range.dart';
import '../../providers/labels.dart';

class LabelsPieChart extends StatelessWidget {
  final LabelType labelType;

  const LabelsPieChart({
    @required this.labelType,
  });

  @override
  Widget build(BuildContext context) {
    final labelsData = Provider.of<Labels>(context, listen: false);
    final range = Provider.of<InsightsRange>(context).range;

    final labels = labelType == LabelType.INCOME
        ? labelsData.incomeLabels
        : labelsData.expenseLabels;

    // Remove the labels with 0 transactions so there's no extra labels.
    labels.removeWhere(
      (label) => label.getLabelTotalWithRange(context, range) == 0,
    );

    // Return something suggesting to add transactions if there's nothing to display in the graph.
    if (labels.isEmpty) {
      return const Center(
        child: Text(
          'Start adding some transactions!',
          style: TextStyle(fontSize: 15),
        ),
      );
    }

    // To calculate percentages for the pie chart labels.
    final total = labels.fold<double>(
      0,
      (previousValue, label) =>
          label.getLabelTotalWithRange(context, range).abs() + previousValue,
    );

    // Sort labels so the label with the most spending shows up first in the legend (descending order).
    labels.sort(
      (a, b) {
        return b
            .getLabelTotalWithRange(context, range)
            .abs()
            .compareTo(a.getLabelTotalWithRange(context, range).abs());
      },
    );

    return PieChartBase(
      id: labelType.toString(),
      animated: false,
      showArcLabels: false,
      // For showing the legend.
      behaviors: <charts.ChartBehavior>[
        charts.DatumLegend(
          position: charts.BehaviorPosition.bottom,
          // Max stuff so graph itself is visible, and legend doesn't take up too much space.
          desiredMaxColumns: 2,
          desiredMaxRows: 3,
          showMeasures: true,
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          measureFormatter: (labelTotal) {
            return '${(labelTotal / total * 100).abs().toStringAsFixed(0)}%';
          },
        ),
      ],
      pieData: labels
          .map(
            (label) => PieChartModel(
              label: label.title,
              amount: label.getLabelTotalWithRange(context, range),
              color: label.color,
            ),
          )
          .toList(),
    );
  }
}
