
import 'package:transcation_history/lib.dart';

extension TransactionTypeParsing on String {
  TransactionType toTransactionType() {
    return TransactionType.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == toLowerCase(),
      orElse: () => TransactionType.values.first,
    );
  }
}
extension CategoryParsing on String {
  Category toCategory() {
    return Category.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == toLowerCase(),
      orElse: () => Category.values.first,
    );
  }
}
extension SubcategoryParsing on String {
  Subcategory toSubcategory() {
    return Subcategory.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == toLowerCase(),
      orElse: () => Subcategory.values.first,
    );
  }
}
