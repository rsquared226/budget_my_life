import 'package:flutter/material.dart';

import '../models/label.dart';

// Used in EditLabelsScreen.

class EditLabelsCard extends StatelessWidget {
  final Label label;
  final Function editTransaction;

  const EditLabelsCard({
    @required this.label,
    @required this.editTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
      elevation: 0,
      child: ListTile(
        leading: Align(
          widthFactor: 1,
          child: CircleAvatar(
            maxRadius: 12,
            backgroundColor: label.color,
          ),
        ),
        title: Text(label.title),
        trailing: IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          onPressed: editTransaction,
        ),
      ),
    );
  }
}
