import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Used in EditLabelScreen.

class ColorPickerFormField extends FormField<Color> {
  static void _showColorPickerDialog(
    BuildContext context,
    Color? currentColor,
    Function onColorChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a label color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor!,
              onColorChanged: onColorChanged as void Function(Color),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('SELECT'),
            ),
          ],
        );
      },
    );
  }

  ColorPickerFormField({
    FormFieldSetter<Color>? onSaved,
    Color? initalValue = Colors.indigo,
    double maxRadius = 14,
  }) : super(
          onSaved: onSaved,
          initialValue: initalValue,
          builder: (state) {
            return GestureDetector(
              onTap: () {
                _showColorPickerDialog(
                  state.context,
                  state.value,
                  (Color selectedColor) {
                    state.didChange(selectedColor);
                  },
                );
              },
              child: CircleAvatar(
                maxRadius: maxRadius,
                backgroundColor: state.value,
              ),
            );
          },
        );
}
