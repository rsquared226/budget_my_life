import 'package:flutter/material.dart';

// Used in EditTransactionScreen.
// The header containing the close button, section title, and the title form field.

class EditTransactionAppbar extends StatelessWidget {
  final Color containerColor;
  final Function closeScreen;
  final String submitButtonText;
  final Function onButtonSubmit;
  final Widget titleFormField;

  const EditTransactionAppbar({
    @required this.containerColor,
    @required this.closeScreen,
    @required this.submitButtonText,
    @required this.onButtonSubmit,
    @required this.titleFormField,
  });

  Widget buildCloseButton(BuildContext context) {
    return IconButton(
      // Padding is 0 to get icon to align with the title form field.
      padding: const EdgeInsets.all(0),
      alignment: Alignment.topLeft,
      icon: Icon(
        Icons.close,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: closeScreen,
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    final themeData = Theme.of(context);
    return FittedBox(
      child: TextButton(
        // Had to do this hacky ButtonTheme stuff to get it aligned to the close button.
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered))
                return Colors.black.withOpacity(0.04);
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed))
                return Colors.black.withOpacity(0.12);
              return null; // Defer to the widget's default.
            },
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.only(bottom: 20, left: 20),
          ),
        ),
        child: Text(
          submitButtonText,
          style: themeData.textTheme.headline6.copyWith(
            color: themeData.colorScheme.onPrimary,
          ),
        ),
        onPressed: onButtonSubmit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Animated because its color can change.
    return AnimatedContainer(
      height: 200,
      width: double.infinity,
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: containerColor,
        // Just so it can have a neat shadow under the header.
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black26
                : Colors.black12,
            spreadRadius: 3,
            blurRadius: 3,
          ),
        ],
      ),
      // SafeArea here so that the close button is not in status bar. We don't want SafeArea surrounding the Container
      // because we want part of the colored Container to be under the status bar to look better.
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildCloseButton(context),
                  buildSubmitButton(context),
                ],
              ),
              const SizedBox(height: 12),
              titleFormField,
            ],
          ),
        ),
      ),
    );
  }
}
