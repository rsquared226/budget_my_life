import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

import '../models/label.dart';
import '../charts/chart_widgets/labels_pie_chart.dart';
import '../charts/chart_widgets/transaction_history_chart.dart';
import '../providers/insights_range.dart';
import '../utils/custom_colors.dart';
import '../widgets/chart_container.dart';

// This screen is a screen under home_screen.

class InsightsScreen extends StatefulWidget {
  @override
  _InsightsScreenState createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final _graphScreens = <Widget>[
    ChartContainer(
      title: 'Income',
      chart: LabelsPieChart(labelType: LabelType.INCOME),
      backgroundColor: CustomColors.incomeColor,
    ),
    ChartContainer(
      title: 'Expenses',
      chart: LabelsPieChart(labelType: LabelType.EXPENSE),
      backgroundColor: CustomColors.expenseColor,
    ),
    ChartContainer(
      title: 'Transaction History',
      chart: TransactionHistoryChart(),
      backgroundColor: Colors.blue[800],
      isTransactionHistoryChart: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    // Used Stack instead of Row so background can be behind ScrollingPageIndicator.
    return Stack(
      children: <Widget>[
        // Use a builder instead of directly accessing the widgets so it's less resource intensive.
        ChangeNotifierProvider(
          create: (_) => InsightsRange(),
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            itemBuilder: (_, index) {
              return _graphScreens[index];
            },
            itemCount: _graphScreens.length,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 7),
          child: ScrollingPageIndicator(
            orientation: Axis.vertical,
            dotColor: Colors.white30,
            dotSelectedColor: Colors.white,
            dotSpacing: 16,
            controller: _pageController,
            itemCount: _graphScreens.length,
          ),
        ),
      ],
    );
  }
}
