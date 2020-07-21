import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

import '../charts_base/pie_chart_base.dart';
import '../chart_models/pie_chart_model.dart';
import '../../utils/custom_colors.dart';

// This is used in TransactionDetailsScreen.

class TransactionDetailsPieChart extends StatelessWidget {
  final String transactionTitle;
  final double transactionAmount;
  final double totalAmount;

  const TransactionDetailsPieChart({
    @required this.transactionTitle,
    @required this.transactionAmount,
    @required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final otherTitle =
        'Other ' + (transactionAmount < 0 ? 'Expenses' : 'Income');
    return PieChartBase(
      id: transactionTitle,
      animated: true,
      showArcLabels: true,
      arcLabelPosition: ArcLabelPosition.outside,
      pieData: [
        PieChartModel(
          label: transactionTitle,
          amount: transactionAmount,
          color: CustomColors.transactionTypeColor(transactionAmount),
        ),
        PieChartModel(
          label: otherTitle,
          amount: totalAmount - transactionAmount,
          color: CustomColors.secondaryTransactionTypeColor(transactionAmount),
        ),
      ],
    );
  }
}
