import 'package:flutter/material.dart';

import '../custom_colors.dart';

// This is what pops up when the FAB on home_screen is clicked.

class EditTransactionScreen extends StatefulWidget {
  // Function that closes this screen.
  final Function closeContainer;

  const EditTransactionScreen({@required this.closeContainer});

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  // TODO: instead of having a dropdown for saying it's an expense or not, instead check if the amount field is negative or positive.
  final _formKey = GlobalKey<FormState>();

  String dropdownTransactionType = 'Expense';

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

    return AnimatedContainer(
      height: 200,
      width: double.infinity,
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: dropdownTransactionType == 'Expense'
            ? Colors.pink.shade900
            : CustomColors.incomeColor,
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

  Widget _buildTransactionTypeDropdownRow() {
    return Row(
      children: <Widget>[
        const Text('Transaction type:'),
        SizedBox(width: 30),
        DropdownButton<String>(
          value: dropdownTransactionType,
          onChanged: (newValue) {
            setState(() {
              dropdownTransactionType = newValue;
            });
          },
          items: <String>['Income', 'Expense'].map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
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
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTransactionTypeDropdownRow(),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: false),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
