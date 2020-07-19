import 'package:flutter/material.dart';

// Used in GraphsScreen.

class ChartContainer extends StatelessWidget {
  final Widget chart;
  final Color color;

  const ChartContainer({
    @required this.chart,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            child: chart,
            height: 275,
          ),
        ),
      ),
    );
  }
}
