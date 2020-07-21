import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../screens/edit_transaction_screen.dart';

// Used in DashboardScreen

const _fabDimension = 56.0;

class DashboardScreenFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_fabDimension / 2),
        ),
      ),
      closedColor: Theme.of(context).primaryColor,
      closedBuilder: (context, _) {
        return SizedBox(
          height: _fabDimension,
          width: _fabDimension,
          child: Center(
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      },
      openBuilder: (_, closeContainer) {
        return EditTransactionScreen(
          closeContainer: closeContainer,
        );
      },
    );
  }
}
