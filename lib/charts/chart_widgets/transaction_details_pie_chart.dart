import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../charts_base/pie_chart_base.dart';
import '../chart_models/pie_chart_model.dart';

// This is used in TransactionDetailsChartView.

class TransactionDetailsPieChart extends StatelessWidget {
  final String transactionTitle;
  final String otherTitle;
  final double transactionAmount;
  final double totalAmount;
  final Color mainColor;
  final Color otherColor;

  const TransactionDetailsPieChart({
    @required this.transactionTitle,
    @required this.otherTitle,
    @required this.transactionAmount,
    @required this.totalAmount,
    @required this.mainColor,
    @required this.otherColor,
  });

  @override
  Widget build(BuildContext context) {
    return PieChartBase(
      id: transactionTitle,
      animated: false,
      showArcLabels: true,
      arcLabelPosition: charts.ArcLabelPosition.outside,
      pieData: [
        PieChartModel(
          label: transactionTitle,
          amount: transactionAmount,
          color: mainColor,
        ),
        PieChartModel(
          label: otherTitle,
          amount: totalAmount - transactionAmount,
          color: otherColor,
        ),
      ],
    );
  }
}
