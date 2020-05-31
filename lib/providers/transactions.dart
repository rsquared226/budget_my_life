import 'package:flutter/foundation.dart';

import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  var _items = <Transaction>[
    Transaction(
      id: 't1',
      title: 'Payday baby',
      amount: 2000,
      transactionType: TransactionType.Income,
    ),
    Transaction(
      id: 't2',
      title: 'New TV',
      amount: 300,
      transactionType: TransactionType.Expense,
    ),
    Transaction(
      id: 't3',
      title: 'Bet',
      amount: 20,
      transactionType: TransactionType.Expense,
      description: 'Oopsie',
    ),
  ];

  List<Transaction> get items {
    return [..._items];
  }

  double get balance {
    var total = 0.0;
    _items.forEach((transaction) {
      if (transaction.transactionType == TransactionType.Income) {
        total += transaction.amount;
      } else {
        total -= transaction.amount;
      }
    });
    return total;
  }

  Transaction findById(String id) {
    return _items.firstWhere((transaction) => transaction.id == id);
  }
}
