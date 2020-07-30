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
  @override
  Widget build(BuildContext context) {
    final insightsRangeData = Provider.of<InsightsRange>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: _chipsData.map(
          (e) {
            final isSelected = e.rangeValue == insightsRangeData.range;

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
                child: Text(e.text),
                onPressed: () {
                  // Don't want to have to unnecessarily call notifyListeners.
                  if (!isSelected) {
                    insightsRangeData.range = e.rangeValue;
                  }
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
