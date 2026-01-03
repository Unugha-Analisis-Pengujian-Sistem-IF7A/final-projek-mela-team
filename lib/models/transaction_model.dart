// lib/models/transaction_model.dart
class TransactionModel {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
}
