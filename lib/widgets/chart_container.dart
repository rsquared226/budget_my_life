import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/insights_range_buttons.dart';

// Used in InsightsScreen.

// TODO: Make chart range change animated so it's less jarring.

class ChartContainer extends StatelessWidget {
  final String title;
  final Widget chart;
  final Color? backgroundColor;
  final bool isTransactionHistoryChart;

  const ChartContainer({
    required this.title,
    required this.chart,
    required this.backgroundColor,
    this.isTransactionHistoryChart = false,
  });

  // In light mode, the background is backgroundColor. In dark mode, the
  // background is the canvas color and the border is backgroundColor.

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? backgroundColor
          : Theme.of(context).canvasColor,
      child: Column(
        children: <Widget>[
          const Spacer(flex: 4),
          Text(
            title,
            style: GoogleFonts.cabin(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          const Spacer(flex: 3),
          Container(
            // Uneven because room is needed for ScrollingPageIndicator.
            margin: const EdgeInsets.only(left: 18, right: 25),
            height: 275,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(13),
              border: Theme.of(context).brightness == Brightness.light
                  ? null
                  : Border.all(color: backgroundColor!, width: 5),
            ),
            child: chart,
          ),
          const Spacer(flex: 3),
          InsightsRangeButtons(
            isTransactionHistoryChart: isTransactionHistoryChart,
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
