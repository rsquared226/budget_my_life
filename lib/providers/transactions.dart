import 'package:flutter/foundation.dart';

import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  var _items = <Transaction>[
    Transaction(
      id: 't1',
      title: 'Payday baby',
      amount: 20000000,
      date: DateTime(2019, 5, 7),
    ),
    Transaction(
      id: 't2',
      title: 'New TV',
      amount: -300,
      date: DateTime(2020, 5, 7),
    ),
    Transaction(
      id: 't3',
      title: 'Bet',
      amount: -20,
      date: DateTime(2019, 8, 29),
      description: 'Oopsie',
    ),
    Transaction(
      id: 't4',
      title: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
      amount: -20,
      date: DateTime.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam aliquam in est in iaculis. Sed suscipit tristique venenatis. Sed egestas tellus et sem mattis, at imperdiet justo semper. Aenean blandit tincidunt sagittis. Nunc pulvinar leo in sapien varius, sit amet sodales mi tempus. In sit amet porta elit, et faucibus erat. Pellentesque hendrerit sapien in lacus vehicula, vitae semper lorem dignissim. Nullam viverra vestibulum tellus eu interdum. Pellentesque nec pellentesque turpis. Donec porta varius porta. Vestibulum tempor sollicitudin ex, id sollicitudin felis iaculis non. Sed sed efficitur lorem. Nulla aliquet metus vel laoreet semper. Phasellus eget dui ut tortor cursus rutrum. Sed tincidunt diam id congue mattis. Pellentesque vitae erat nec tortor tempus porttitor. Nullam accumsan pretium suscipit. Donec condimentum, est sit amet aliquam eleifend, erat arcu gravida nisl, quis commodo purus ipsum eu turpis. Pellentesque tristique laoreet tortor. Nulla elit orci, cursus nec tincidunt ut, molestie id sem. Cras varius eget ligula nec pellentesque. Quisque et orci nec ante cursus vestibulum a quis arcu. Vivamus ante ligula, porta sit amet iaculis a, ultricies porta nibh. Ut sollicitudin facilisis purus quis tincidunt. Mauris quis gravida leo.',
    ),
  ];

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
    return _items.firstWhere((transaction) => transaction.id == id);
  }

  void addTransaction(Transaction newTransaction) {
    _items.add(newTransaction);
    notifyListeners();
  }

  void editTransaction(Transaction editedTransaction) {
    final editedIndex = _items
        .indexWhere((transaction) => editedTransaction.id == transaction.id);

    if (editedIndex == null) {
      return;
    }
    _items[editedIndex] = editedTransaction;
    notifyListeners();
  }
}
