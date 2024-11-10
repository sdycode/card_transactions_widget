// ignore_for_file: public_member_api_docs, sort_constructors_first

// Transaction, DayData, and MonthlyData Class Definitions
import 'dart:convert';

import 'package:transcation_history/lib.dart';

class Transaction {
  final DateTime date;
  final int amount;
  final TransactionType type;
  final Category category;
  final Subcategory subcategory;
  final String description;

  Transaction({
    required this.date,
    required this.amount,
    required this.type,
    required this.category,
    required this.subcategory,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'amount': amount,
        'type': type.name,
        'category': category.name,
        'subcategory': subcategory.name,
        'description': description,
      };

  Transaction copyWith({
    DateTime? date,
    int? amount,
    TransactionType? type,
    Category? category,
    Subcategory? subcategory,
    String? description,
  }) {
    return Transaction(
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
      'type': type.name,
      'category': category.name,
      'subcategory': subcategory.name,
      'description': description,
    };
  }

  factory Transaction.fromMap(Map map) {
    return Transaction(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: (map['amount'] as num).toInt(),
      type: ((map['type'] ?? "") as String).toTransactionType(),
      category: ((map['category'] ?? "") as String).toCategory(),
      subcategory: ((map['subcategory'] ?? "") as String).toSubcategory(),
      description: map['description'] as String,
    );
  }

 
  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(date: $date, amount: $amount, type: $type, category: $category, subcategory: $subcategory, description: $description)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.amount == amount &&
        other.type == type &&
        other.category == category &&
        other.subcategory == subcategory &&
        other.description == description;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        category.hashCode ^
        subcategory.hashCode ^
        description.hashCode;
  }
}
