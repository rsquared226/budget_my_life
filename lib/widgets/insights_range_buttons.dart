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
  _ChipsData(rangeValue: Range.thirtyDays, text: 'PAST 30 DAYS'),
  _ChipsData(rangeValue: Range.sevenDays, text: 'PAST 7 DAYS'),
];

class InsightsRangeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final insightsRangeData = Provider.of<InsightsRange>(context);

    return Wrap(
      spacing: 10,
      children: _chipsData.map(
        (e) {
          return FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              side: BorderSide(color: Colors.green),
            ),
            child: Text(e.text),
            onPressed: () {
              // Don't want to have to unnecessarily call notifyListeners.
              if (e.rangeValue != insightsRangeData.range) {
                insightsRangeData.range = e.rangeValue;
              }
            },
          );
        },
      ).toList(),
    );
  }
}
