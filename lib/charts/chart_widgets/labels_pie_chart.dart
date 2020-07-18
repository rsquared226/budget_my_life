import 'package:budget_my_life/charts/chart_models/pie_chart_model.dart';
import 'package:budget_my_life/charts/charts_base/pie_chart_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/label.dart';
import '../../providers/labels.dart';

class LabelsPieChart extends StatelessWidget {
  final LabelType labelType;

  const LabelsPieChart({
    @required this.labelType,
  });

  @override
  Widget build(BuildContext context) {
    final labelsData = Provider.of<Labels>(context, listen: false);
    final labels = labelType == LabelType.INCOME
        ? labelsData.incomeLabels
        : labelsData.expenseLabels;

    return PieChartBase(
      id: labelType.toString(),
      animated: false,
      pieData: labels
          .map(
            (label) => PieChartModel(
              label: label.title,
              amount: label.getLabelTotal(context),
              color: label.color,
            ),
          )
          .toList(),
    );
  }
}
