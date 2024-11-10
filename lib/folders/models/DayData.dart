// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:transcation_history/lib.dart';


class DayData {
  final int day;
  final List<Transaction> transactions;
  DayData({
    required this.day,
    required this.transactions,
  });

  DayData copyWith({
    int? day,
    List<Transaction>? transactions,
  }) {
    return DayData(
      day: day ?? this.day,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'transactions': transactions.map((x) => x.toMap()).toList(),
    };
  }

  factory DayData.fromMap(Map map) {
    return DayData(
      day: map['day'] as int,
      transactions: List<Transaction>.from(
        ((map['transactions'] ?? []) as List).map<Transaction>(
          (x) => Transaction.fromMap(x as Map),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DayData.fromJson(String source) =>
      DayData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DayData(day: $day, transactions: $transactions)';

  @override
  bool operator ==(covariant DayData other) {
    if (identical(this, other)) return true;

    return other.day == day && listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode => day.hashCode ^ transactions.hashCode;
}
