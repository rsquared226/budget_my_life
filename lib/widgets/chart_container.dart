import 'package:flutter/material.dart';

// Used in GraphsScreen.

class ChartContainer extends StatelessWidget {
  final Widget chart;
  final Color backgroundColor;

  const ChartContainer({
    @required this.chart,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Container(
          // Uneven because room is needed for ScrollingPageIndicator.
          margin: const EdgeInsets.only(left: 18, right: 25),
          height: 275,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: chart,
        ),
      ),
    );
  }
}
