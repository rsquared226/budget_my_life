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
  final _formKey = GlobalKey<FormState>();

  // Used for determining what color the form header should be based on if it's positive or negative.
  final _amountController = TextEditingController();

  // The header containing the close button, section title, and the title form field.
  Widget _buildFormHeader(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    final amount = double.tryParse(_amountController.text);
    // By default we will assume the transaction is an income.
    final containerColor = amount != null && amount < 0
        ? Colors
            .pink.shade900 // Different color here because red seemed too harsh.
        : CustomColors.incomeColor;
    final stringTransactionType =
        amount != null && amount < 0 ? 'Expense' : 'Income';

    Widget buildCloseButton() => IconButton(
          // Padding is 0 to get icon to align with the title form field.
          padding: const EdgeInsets.all(0),
          alignment: Alignment.topLeft,
          icon: Icon(
            Icons.close,
            color: onPrimaryColor,
          ),
          onPressed: widget.closeContainer,
        );

    // TODO: Make this a submit button
    Widget buildSectionTitle() => Text(
          'Add $stringTransactionType',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: onPrimaryColor,
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
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildCloseButton(),
                  buildSectionTitle(),
                ],
              ),
              buildTitleFormField(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // Ensure that the section header is updated when the amount field is updated.
    _amountController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        helperText:
                            'If this is an expense, make the amount negative.',
                      ),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
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
