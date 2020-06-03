import 'package:flutter/material.dart';

// This is what pops up when the FAB on home_screen is clicked.

class EditTransactionScreen extends StatefulWidget {
  // Function that closes this screen.
  final Function closeContainer;

  const EditTransactionScreen({@required this.closeContainer});

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  // The header containing the close button and the title form field.
  Widget _buildFormHeader(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    Widget buildCloseButton() => Align(
          heightFactor: 1,
          alignment: Alignment.topLeft,
          child: IconButton(
            // Padding is 0 to get icon to align with the title form field.
            padding: const EdgeInsets.all(0),
            alignment: Alignment.topLeft,
            icon: Icon(
              Icons.close,
              color: onPrimaryColor,
            ),
            onPressed: widget.closeContainer,
          ),
        );

    Widget buildTitleFormField() => TextFormField(
          decoration: InputDecoration(
            labelText: 'Title',
            labelStyle: TextStyle(color: onPrimaryColor),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: onPrimaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          style: TextStyle(color: onPrimaryColor),
          cursorColor: Theme.of(context).accentColor,
        );

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
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
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildCloseButton(),
              buildTitleFormField(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildFormHeader(context),
          ],
        ),
      ),
    );
  }
}
