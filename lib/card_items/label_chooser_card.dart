import 'package:flutter/material.dart';

// Used in EditTransactionScreen in the LabelChooserDialog.

class LabelChooserCard extends StatelessWidget {
  final Color color;
  final String title;

  const LabelChooserCard({
    @required this.color,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 18,
        backgroundColor: color,
      ),
      title: Text(title),
    );
  }
}
