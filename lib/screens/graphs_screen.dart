import 'package:flutter/material.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

import '../models/label.dart';
import '../charts/chart_widgets/labels_pie_chart.dart';
import '../utils/custom_colors.dart';
import '../widgets/chart_container.dart';

// This screen is a screen under home_screen
// TODO: Change color of bottom tabs using provider (?)

class GraphsScreen extends StatefulWidget {
  @override
  _GraphsScreenState createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final _graphScreens = <Widget>[
    ChartContainer(
      chart: LabelsPieChart(labelType: LabelType.INCOME),
      backgroundColor: CustomColors.incomeColor,
    ),
    ChartContainer(
      chart: LabelsPieChart(labelType: LabelType.EXPENSE),
      backgroundColor: CustomColors.expenseColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Used Stack instead of Row so background can be behind ScrollingPageIndicator.
    return Stack(
      children: <Widget>[
        // Use a builder instead of directly accessing the widgets so it's less resource intensive.
        PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemBuilder: (_, index) {
            // TODO: do the color change thing here.
            return _graphScreens[index];
          },
          itemCount: _graphScreens.length,
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 7),
          child: ScrollingPageIndicator(
            orientation: Axis.vertical,
            dotColor: Colors.white30,
            dotSelectedColor: Colors.white,
            controller: _pageController,
            itemCount: _graphScreens.length,
          ),
        ),
      ],
    );
  }
}
