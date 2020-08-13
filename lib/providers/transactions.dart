import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/db_helper.dart';
import '../models/transaction.dart';
import './insights_range.dart';
import './labels.dart';

class Transactions with ChangeNotifier {
  var _items = <Transaction>[];

  List<Transaction> get items {
    // Sort items in non-chronological order.
    _items.sort((a, b) => b.date.compareTo(a.date));
    return [..._items];
  }

  // Add them because incomeTotal will always produce a positive amount
  // while expensesTotal will always produce a negative amount.
  double get balance {
    return incomeTotal + expensesTotal;
  }

  double get monthlyBalance {
    return monthIncomeTotal + monthExpensesTotal;
  }

  double get incomeTotal {
    return _totalTransactionsAmountWithFilter(
      (transaction) => transaction.amount > 0,
    );
  }

  double get expensesTotal {
    return _totalTransactionsAmountWithFilter(
      (transaction) => transaction.amount < 0,
    );
  }

  double get monthIncomeTotal {
    return _totalTransactionsAmountWithFilter(
      (transaction) =>
          transaction.amount > 0 && transaction.isAfterBeginningOfMonth,
    );
  }

  double get monthExpensesTotal {
    return _totalTransactionsAmountWithFilter(
      (transaction) =>
          transaction.amount < 0 && transaction.isAfterBeginningOfMonth,
    );
  }

  List<Transaction> get sevenDaysTransactions {
    return items.where((transaction) => transaction.isWithin7Days).toList();
  }

  double _totalTransactionsAmountWithFilter(
      bool Function(Transaction transaction) filter) {
    var transactions = [..._items];
    transactions.retainWhere(filter);

    // This simply totals the amounts from transactions.
    return transactions.fold<double>(
      0,
      (previousValue, transaction) => previousValue + transaction.amount,
    );
  }

  Transaction findById(String id) {
    return _items.firstWhere(
      (transaction) => transaction.id == id,
      orElse: () => null,
    );
  }

  List<Transaction> filterTransactionsByLabelAndRange(
      BuildContext context, String labelId, Range range) {
    return _internalFilterTransactionsByRange(
      range,
      filterTransactionsByLabel(context, labelId),
    );
  }

  List<Transaction> filterTransactionsByLabel(
      BuildContext context, String labelId) {
    if (labelId == null) {
      return items;
    }
    _pruneDeletedLabelIds(context);
    // Use the getter so transactions are already sorted.
    return items
        .where((transaction) => transaction.labelId == labelId)
        .toList();
  }

  // So the optional positional argument isn't visible outside the class.
  List<Transaction> filterTransactionsByRange(Range range) =>
      _internalFilterTransactionsByRange(range);

  // optionalItems so filterTransactionByLabelAndRange is easy.
  List<Transaction> _internalFilterTransactionsByRange(Range range,
      [List<Transaction> optionalItems]) {
    var transactions = optionalItems ?? items;

    switch (range) {
      case Range.lifetime:
        return transactions;

      case Range.month:
        transactions.retainWhere(
          (transaction) => transaction.isAfterBeginningOfMonth,
        );
        return transactions;

      case Range.week:
        transactions.retainWhere(
          (transaction) => transaction.isAfterBeginningOfWeek,
        );
        return transactions;

      default:
        throw UnimplementedError('An unimplemented or null range was passed.');
    }
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
  void _pruneDeletedLabelIds(BuildContext context) {
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
