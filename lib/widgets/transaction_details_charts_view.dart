import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

import '../charts/chart_widgets/transaction_details_pie_chart.dart';
import '../providers/transactions.dart';
import '../utils/custom_colors.dart';

// Used in TransactionDetailsScreen.
// TODO: make it so that this month's transactions are shown with other month totals.

class TransactionDetailsChartsView extends StatefulWidget {
  final String transactionId;

  const TransactionDetailsChartsView({
    @required this.transactionId,
  });

  @override
  _TransactionDetailsChartsViewState createState() =>
      _TransactionDetailsChartsViewState();
}

class _TransactionDetailsChartsViewState
    extends State<TransactionDetailsChartsView> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final transaction = transactionsData.findById(widget.transactionId);
    final label = transaction.getLabel(context);

    return Column(
      children: <Widget>[
        // Need SizedBox or PageView will attempt to take up entire vertical viewport.
        SizedBox(
          height: 290,
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              TransactionDetailsPieChart(
                chartTitle: 'Impact on Label ${label.title}',
                transactionTitle: transaction.title,
                otherTitle: 'Rest of ${label.title}',
                transactionAmount: transaction.amount,
                totalAmount: label.getLabelAmountTotal(context),
                mainColor: label.color,
                otherColor: label.color.withAlpha(125),
              ),
              TransactionDetailsPieChart(
                chartTitle:
                    'Impact on ${transaction.amount < 0 ? 'Expense' : 'Income'} Totals',
                transactionTitle: transaction.title,
                otherTitle:
                    'Rest of ${transaction.amount < 0 ? 'Expenses' : 'Income'}',
                transactionAmount: transaction.amount,
                totalAmount: transaction.amount > 0
                    ? transactionsData.incomeTotal
                    : transactionsData.expensesTotal,
                mainColor:
                    CustomColors.transactionTypeColor(transaction.amount),
                otherColor: CustomColors.secondaryTransactionTypeColor(
                    transaction.amount),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ScrollingPageIndicator(
          controller: _pageController,
          itemCount: 2,
        ),
      ],
    );
  }
}
