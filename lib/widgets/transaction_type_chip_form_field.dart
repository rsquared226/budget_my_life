import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../models/label.dart';

// Used in EditLabelScreen.

class TransactionTypeChipFormField extends FormField<LabelType> {
  static const _avatarSizes = 18.0;

  static Widget _buildChoiceChip(
    FormFieldState<LabelType> state,
    Color color,
    LabelType labelType,
  ) {
    return ChoiceChip(
      // Mimic the leading widget of TransactionCard.
      avatar: Container(
        height: _avatarSizes,
        width: _avatarSizes,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      label: Text(labelType == LabelType.INCOME ? 'Income' : 'Expense'),
      selected: state.value == labelType,
      onSelected: (isSelected) {
        state.didChange(isSelected ? labelType : null);
      },
    );
  }

  TransactionTypeChipFormField({
    FormFieldSetter<LabelType> onSaved,
    FormFieldValidator<LabelType> validator,
    LabelType initialValue,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    _buildChoiceChip(
                      state,
                      CustomColors.incomeColor,
                      LabelType.INCOME,
                    ),
                    const SizedBox(width: 6),
                    _buildChoiceChip(
                      state,
                      CustomColors.expenseColor,
                      LabelType.EXPENSE,
                    ),
                  ],
                ),
                if (state.hasError)
                  Text(
                    state.errorText,
                    style: TextStyle(
                      color: Theme.of(state.context).errorColor,
                    ),
                  ),
              ],
            );
          },
        );
}
