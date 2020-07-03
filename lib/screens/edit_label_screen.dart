import 'package:flutter/material.dart';

import '../widgets/color_picker_form_field.dart';
import '../widgets/transaction_type_chip_form_field.dart';

// This screen is navigated from the EditLabelsScreen.
// TODO: Make adding/editing labels inline/in a modal on the same screen.

class EditLabelScreen extends StatefulWidget {
  // If this is null, we are adding a label. If not, we are editing a label.
  final String editLabelId;

  const EditLabelScreen({
    this.editLabelId,
  });

  @override
  _EditLabelScreenState createState() => _EditLabelScreenState();
}

class _EditLabelScreenState extends State<EditLabelScreen> {
  final _formKey = GlobalKey<FormState>();

  void _saveForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.editLabelId == null ? 'Add' : 'Edit'} Label'),
        actions: <Widget>[
          FlatButton(
            onPressed: _saveForm,
            child: Text(
              'SAVE',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          children: <Widget>[
            Row(
              children: <Widget>[
                ColorPickerFormField(),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title.';
                      }
                      if (value.length > 30) {
                        return 'Please shorten your title from ${value.length} characters to 30.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TransactionTypeChipFormField(
              validator: (value) {
                if (value == null) {
                  return 'Please choose a label type.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
