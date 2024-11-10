// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:transcation_history/lib.dart';

class DateWiseDataInYear {
  String year;
  Map<String, List<Transaction>> transactionsByDay = {};
  Map<String, int> transactionTotals = {};
  DateWiseDataInYear({
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'year': year,
    };
  }

  factory DateWiseDataInYear.fromMap(Map<String, dynamic> map) {
    return DateWiseDataInYear(
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DateWiseDataInYear.fromJson(String source) =>
      DateWiseDataInYear.fromMap(json.decode(source) as Map<String, dynamic>);

  DateWiseDataInYear copyWith({
    String? year,
  }) {
    return DateWiseDataInYear(
      year: year ?? this.year,
    );
  }

  @override
  String toString() => 'DateWiseDataInYear(year: $year)';

  @override
  bool operator ==(covariant DateWiseDataInYear other) {
    if (identical(this, other)) return true;
  
    return 
      other.year == year;
  }

  @override
  int get hashCode => year.hashCode;

}
 