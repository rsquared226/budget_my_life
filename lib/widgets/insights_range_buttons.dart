import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/insights_range.dart';

class _ChipsData {
  final Range rangeValue;
  final String text;

  const _ChipsData({
    @required this.rangeValue,
    @required this.text,
  });
}

const _chipsData = const <_ChipsData>[
  _ChipsData(rangeValue: Range.lifetime, text: 'LIFETIME'),
  _ChipsData(rangeValue: Range.month, text: 'THIS MONTH'),
  _ChipsData(rangeValue: Range.week, text: 'THIS WEEK'),
];

class InsightsRangeButtons extends StatelessWidget {
  // The transaction history chart doesn't have any options, only stuff from the past 7 days.
  final bool isTransactionHistoryChart;

  const InsightsRangeButtons({
    this.isTransactionHistoryChart = false,
  });

  Widget buildRangeButton(
      bool isSelected, _ChipsData e, InsightsRange insightsRangeData) {
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            width: 2,
            color: isSelected ? Colors.white60 : Colors.transparent,
          ),
        ),
        textColor: isSelected ? Colors.white : Colors.white54,
        child: FittedBox(
          child: Text(e.text),
        ),
        onPressed: () {
          // Don't want to have to unnecessarily call notifyListeners.
          if (!isSelected) {
            insightsRangeData.range = e.rangeValue;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isTransactionHistoryChart) {
      return FlatButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            width: 2,
            color: Colors.white60,
          ),
        ),
        textColor: Colors.white,
        child: const FittedBox(
          child: Text('PAST 7 DAYS'),
        ),
      );
    }

    final insightsRangeData = Provider.of<InsightsRange>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: _chipsData.map(
          (e) {
            final isSelected = e.rangeValue == insightsRangeData.range;

            return buildRangeButton(isSelected, e, insightsRangeData);
          },
        ).toList(),
      ),
    );
  }
}
