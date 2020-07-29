import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../charts_base/pie_chart_base.dart';
import '../chart_models/pie_chart_model.dart';

// This is used in TransactionDetailsChartView.

class TransactionDetailsPieChart extends StatelessWidget {
  final String chartTitle;
  final String transactionTitle;
  final String otherTitle;
  final double transactionAmount;
  final double totalAmount;
  final Color mainColor;
  final Color otherColor;
  final double height;

  const TransactionDetailsPieChart({
    @required this.chartTitle,
    @required this.transactionTitle,
    @required this.otherTitle,
    @required this.transactionAmount,
    @required this.totalAmount,
    @required this.mainColor,
    @required this.otherColor,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Just in case the text overflows.
        FittedBox(
          child: Text(
            chartTitle,
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
          ),
        ),
        SizedBox(
          height: height,
          child: PieChartBase(
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
          ),
        ),
      ],
    );
  }
}
