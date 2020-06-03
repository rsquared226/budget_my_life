import 'package:flutter/foundation.dart';

import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  var _items = <Transaction>[
    Transaction(
      id: 't1',
      title: 'Payday baby',
      amount: 20000000,
      date: DateTime(2019, 5, 7),
      transactionType: TransactionType.Income,
    ),
    Transaction(
      id: 't2',
      title: 'New TV',
      amount: 300,
      date: DateTime(2020, 5, 7),
      transactionType: TransactionType.Expense,
    ),
    Transaction(
      id: 't3',
      title: 'Bet',
      amount: 20,
      date: DateTime(2019, 8, 29),
      transactionType: TransactionType.Expense,
      description: 'Oopsie',
    ),
    Transaction(
      id: 't4',
      title:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque a nulla in orci viverra scelerisque. Nullam dignissim sit amet orci.',
      amount: 20,
      date: DateTime.now(),
      transactionType: TransactionType.Expense,
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

  void addTransaction(Transaction newTransaction) {
    _items.add(newTransaction);
    notifyListeners();
  }
}
