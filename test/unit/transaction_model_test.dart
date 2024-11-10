 import 'package:flutter_test/flutter_test.dart';
import 'package:transcation_history/lib.dart';
 
void main() {
  group('Transaction Model', () {
    final sampleDate = DateTime(2024, 1, 1);
    final sampleTransaction = Transaction(
      date: sampleDate,
      amount: 500,
      type: TransactionType.credit,
      category: Category.foodAndDining,
      subcategory: Subcategory.groceries,
      description: "Grocery shopping",
    );

    test('toJson should serialize Transaction to correct JSON format', () {
      final json = sampleTransaction.toJson();
      expect(json['date'], sampleDate.toIso8601String());
      expect(json['amount'], 500);
      expect(json['type'], 'credit');
      expect(json['category'], 'foodAndDining');
      expect(json['subcategory'], 'groceries');
      expect(json['description'], 'Grocery shopping');
    });

    test('fromJson should deserialize JSON to correct Transaction object', () {
      final jsonString = jsonEncode({
        'date': sampleDate.toIso8601String(),
        'amount': 500,
        'type': 'credit',
        'category': 'foodAndDining',
        'subcategory': 'groceries',
        'description': 'Grocery shopping',
      });
      final transaction = Transaction.fromJson(jsonString);

      expect(transaction.date, sampleDate);
      expect(transaction.amount, 500);
      expect(transaction.type, TransactionType.credit);
      expect(transaction.category, Category.foodAndDining);
      expect(transaction.subcategory, Subcategory.groceries);
      expect(transaction.description, 'Grocery shopping');
    });

    test('toMap should convert Transaction to correct map format', () {
      final map = sampleTransaction.toMap();

      expect(map['date'], sampleDate.millisecondsSinceEpoch);
      expect(map['amount'], 500);
      expect(map['type'], 'credit');
      expect(map['category'], 'foodAndDining');
      expect(map['subcategory'], 'groceries');
      expect(map['description'], 'Grocery shopping');
    });

    test('fromMap should convert map to correct Transaction object', () {
      final map = {
        'date': sampleDate.millisecondsSinceEpoch,
        'amount': 500,
        'type': 'credit',
        'category': 'foodAndDining',
        'subcategory': 'groceries',
        'description': 'Grocery shopping',
      };
      final transaction = Transaction.fromMap(map);

      expect(transaction.date, sampleDate);
      expect(transaction.amount, 500);
      expect(transaction.type, TransactionType.credit);
      expect(transaction.category, Category.foodAndDining);
      expect(transaction.subcategory, Subcategory.groceries);
      expect(transaction.description, 'Grocery shopping');
    });

    test('copyWith should create a modified copy of Transaction', () {
      final modifiedTransaction = sampleTransaction.copyWith(
        amount: 700,
        description: 'Modified Description',
      );

      expect(modifiedTransaction.date, sampleDate);
      expect(modifiedTransaction.amount, 700);
      expect(modifiedTransaction.description, 'Modified Description');
      expect(modifiedTransaction.type, TransactionType.credit);
      expect(modifiedTransaction.category, Category.foodAndDining);
      expect(modifiedTransaction.subcategory, Subcategory.groceries);
    });

    test('Equality operator should compare Transactions based on properties', () {
      final anotherTransaction = Transaction(
        date: sampleDate,
        amount: 500,
        type: TransactionType.credit,
        category: Category.foodAndDining,
        subcategory: Subcategory.groceries,
        description: "Grocery shopping",
      );

      expect(sampleTransaction, anotherTransaction);
      expect(sampleTransaction.hashCode, anotherTransaction.hashCode);
    });

    test('toString should return correct string representation', () {
      final stringRepresentation = sampleTransaction.toString();
      expect(
        stringRepresentation,
        'Transaction(date: $sampleDate, amount: 500, type: TransactionType.credit, '
        'category: Category.foodAndDining, subcategory: Subcategory.groceries, '
        'description: Grocery shopping)',
      );
    });
  });
}
