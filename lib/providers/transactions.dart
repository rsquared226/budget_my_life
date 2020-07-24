import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/db_helper.dart';
import '../models/transaction.dart';
import './labels.dart';

class Transactions with ChangeNotifier {
  var _items = <Transaction>[];

  List<Transaction> get items {
    // Sort items in non-chronological order.
    _items.sort((a, b) => b.date.compareTo(a.date));
    return [..._items];
  }

  double get balance {
    return incomeTotal + expensesTotal;
  }

  double get expensesTotal {
    var totalExpenses = 0.0;
    _items.forEach((transaction) {
      if (transaction.amount < 0) {
        totalExpenses += transaction.amount;
      }
    });
    return totalExpenses;
  }

  double get incomeTotal {
    var totalIncome = 0.0;
    _items.forEach((transaction) {
      if (transaction.amount > 0) {
        totalIncome += transaction.amount;
      }
    });
    return totalIncome;
  }

  Transaction findById(String id) {
    return _items.firstWhere(
      (transaction) => transaction.id == id,
      orElse: () => null,
    );
  }

  List<Transaction> filterTransactions(BuildContext context, String labelId) {
    if (labelId == null) {
      return items;
    }
    pruneDeletedLabelIds(context);
    // Use the getter so transactions are already sorted.
    return items
        .where((transaction) => transaction.labelId == labelId)
        .toList();
  }

  void addTransaction(Transaction newTransaction) {
    _items.add(newTransaction);
    notifyListeners();
    DBHelper.insertTransaction(newTransaction);
  }

  void editTransaction(Transaction editedTransaction) {
    final editedIndex = _items
        .indexWhere((transaction) => editedTransaction.id == transaction.id);

    if (editedIndex == null) {
      return;
    }
    _items[editedIndex] = editedTransaction;
    notifyListeners();
    DBHelper.updateTransaction(editedTransaction);
  }

  void deleteTransaction(String id) {
    _items.removeWhere((transaction) => transaction.id == id);
    notifyListeners();
    DBHelper.deleteTransaction(id);
  }

  Future<void> fetchAndSetTransactions() async {
    _items = await DBHelper.getTransactions();
    notifyListeners();
  }

  // If a transaction has the id of a deleted label, replace it with one of the default labels.
  void pruneDeletedLabelIds(BuildContext context) {
    final labelsData = Provider.of<Labels>(context, listen: false);

    for (var i = 0; i < _items.length; i++) {
      final transaction = _items[i];
      if (labelsData.findById(transaction.labelId) == null) {
        final newLabelId = transaction.amount >= 0
            ? Labels.otherIncomeId
            : Labels.otherExpenseId;

        _items[i] = Transaction(
          id: transaction.id,
          title: transaction.title,
          amount: transaction.amount,
          date: transaction.date,
          labelId: newLabelId,
        );
        DBHelper.updateTransaction(_items[i]);
      }
    }
  }
}
