import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  var _items = <Transaction>[];

  List<Transaction> get items {
    // Sort items in non-chronological order.
    _items.sort((a, b) => b.date.compareTo(a.date));
    return [..._items];
  }

  double get balance {
    return incomeTotal - expensesTotal;
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

  String get formattedBalance {
    var formattedBalance = '\$${balance.abs().toStringAsFixed(2)}';
    if (balance < 0) {
      formattedBalance = '-' + formattedBalance;
    }
    return formattedBalance;
  }

  Transaction findById(String id) {
    return _items.firstWhere(
      (transaction) => transaction.id == id,
      orElse: () => null,
    );
  }

  void addTransaction(Transaction newTransaction) {
    _items.add(newTransaction);
    notifyListeners();
    DBHelper.insert(newTransaction);
  }

  // TODO: Check if the all the stuff before dbhelper is needed.
  void editTransaction(Transaction editedTransaction) {
    final editedIndex = _items
        .indexWhere((transaction) => editedTransaction.id == transaction.id);

    if (editedIndex == null) {
      return;
    }
    _items[editedIndex] = editedTransaction;
    notifyListeners();
    DBHelper.update(editedTransaction);
  }

  void deleteTransaction(String id) {
    _items.removeWhere((transaction) => transaction.id == id);
    notifyListeners();
    DBHelper.delete(id);
  }

  Future<void> fetchAndSetTransactions() async {
    final dataList = await DBHelper.getData();
    _items = dataList
        .map((item) => Transaction(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              amount: item['amount'],
              date: DateTime.fromMillisecondsSinceEpoch(item['date']),
            ))
        .toList();
    notifyListeners();
  }
}
