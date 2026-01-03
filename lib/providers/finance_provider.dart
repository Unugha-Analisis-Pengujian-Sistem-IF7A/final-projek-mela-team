// lib/providers/finance_provider.dart
import 'package:flutter/foundation.dart';
import 'dart:collection';
import '../models/transaction_model.dart';

class FinanceProvider extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  UnmodifiableListView<TransactionModel> get transactions =>
      UnmodifiableListView(_transactions);

  double get totalIncome => _transactions
      .where((t) => t.amount > 0)
      .fold(0.0, (prev, el) => prev + el.amount);

  double get totalExpense => _transactions
      .where((t) => t.amount < 0)
      .fold(0.0, (prev, el) => prev + el.amount.abs());

  double get balance => totalIncome - totalExpense;

  void addTransaction(TransactionModel t) {
    _transactions.add(t);
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void clearAll() {
    _transactions.clear();
    notifyListeners();
  }
}
