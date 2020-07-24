import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/label.dart';
import '../providers/labels.dart';
import '../widgets/color_picker_form_field.dart';
import '../widgets/transaction_type_chip_form_field.dart';

// This screen is navigated from the EditLabelsScreen.
// TODO: Make adding/editing labels inline/in a modal on the same screen.

// Just to make saving the form easier.
class EditableLabel {
  // If a label is being edited, the id should never change.
  // If a label is being added, the id will be null until it is converted to a Label.
  final String id;
  String title;
  Color color;
  LabelType labelType;

  EditableLabel({
    this.id,
    this.title = '',
    this.color = Colors.indigo,
    this.labelType,
  });

  Label toLabel() {
    return Label(
      id: id ?? DateTime.now().toString(),
      title: title,
      color: color,
      labelType: labelType,
    );
  }
}

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

  // Initialized in initState.
  Labels _labelsData;
  EditableLabel _editableLabel;

  void _saveForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (widget.editLabelId == null) {
      _labelsData.addLabel(_editableLabel.toLabel());
    } else {
      _labelsData.editLabel(_editableLabel.toLabel());
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    _labelsData = Provider.of<Labels>(context, listen: false);

    if (widget.editLabelId != null) {
      final initLabel = _labelsData.findById(widget.editLabelId);

      _editableLabel = EditableLabel(
        id: initLabel.id,
        title: initLabel.title,
        color: initLabel.color,
        labelType: initLabel.labelType,
      );
    } else {
      _editableLabel = EditableLabel();
    }

    super.initState();
  }

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
                ColorPickerFormField(
                  initalValue: _editableLabel.color,
                  onSaved: (newValue) {
                    _editableLabel.color = newValue;
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    textCapitalization: TextCapitalization.words,
                    initialValue: _editableLabel.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title.';
                      }
                      if (value.length > 20) {
                        return 'Please shorten your title from ${value.length} characters to 20.';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editableLabel.title = newValue;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TransactionTypeChipFormField(
              initialValue: _editableLabel.labelType,
              validator: (value) {
                // Don't allow changing of label types if the label exists. The label then would have to be unlinked to
                // all its transactions (since they would be of the other transaction type). At that point, it's just
                // easier to delete this label and create a new one.
                if (widget.editLabelId != null &&
                    value !=
                        _labelsData.findById(widget.editLabelId).labelType) {
                  return 'Cannot change the type of existing label.';
                }
                if (value == null) {
                  return 'Please choose a label type.';
                }
                return null;
              },
              onSaved: (newValue) {
                _editableLabel.labelType = newValue;
              },
            ),
            const SizedBox(height: 5),
            RaisedButton.icon(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: _saveForm,
              icon: const Icon(Icons.save),
              label: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}
