import 'package:flutter/material.dart';

import '../widgets/color_picker_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.editLabelId == null ? 'Add' : 'Edit'} Label'),
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
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
