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
    // Had to do this hacky ButtonTheme stuff to get it aligned to the close button.
    return FittedBox(
      child: ButtonTheme(
        height: 0,
        padding: const EdgeInsets.only(bottom: 20, left: 20),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: FlatButton(
          child: Text(
            submitButtonText,
            style: themeData.textTheme.headline6.copyWith(
              color: themeData.colorScheme.onPrimary,
            ),
          ),
          onPressed: onButtonSubmit,
        ),
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
            color: Colors.grey.withOpacity(.5),
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
