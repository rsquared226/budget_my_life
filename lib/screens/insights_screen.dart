import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  @override
  Widget build(BuildContext context) {
    final _graphScreens = <Widget>[
      ChartContainer(
        title: 'Income',
        chart: LabelsPieChart(labelType: LabelType.INCOME),
        backgroundColor: Theme.of(context).colorScheme.incomeColor,
      ),
      ChartContainer(
        title: 'Expenses',
        chart: LabelsPieChart(labelType: LabelType.EXPENSE),
        backgroundColor: Theme.of(context).colorScheme.expenseColor,
      ),
      ChartContainer(
        title: 'Transaction History',
        chart: TransactionHistoryChart(),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.blue[800]
            : Colors.blueGrey[400],
        isTransactionHistoryChart: true,
      )
    ];

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
          child: SmoothPageIndicator(
            controller: _pageController,
            count: _graphScreens.length,
            axisDirection: Axis.vertical,
            effect: SlideEffect(
              spacing: 16,
              dotColor: Colors.white30,
              activeDotColor: Colors.white
            ),
          ),

        ),
      ],
    );
  }
}
