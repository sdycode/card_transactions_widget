

import 'package:transcation_history/lib.dart';

class MonthlyData {
  final int month;
  final List<DayData> daysList;
  MonthlyData({
    required this.month,
    required this.daysList,
  });

  MonthlyData copyWith({
    int? month,
    List<DayData>? daysList,
  }) {
    return MonthlyData(
      month: month ?? this.month,
      daysList: daysList ?? this.daysList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'daysList': daysList.map((x) => x.toMap()).toList(),
    };
  }

  factory MonthlyData.fromMap(Map map) {
    return MonthlyData(
      month: map['month'] as int,
      daysList: List<DayData>.from(
        ((map['daysList'] ?? []) as List).map<DayData>(
          (x) => DayData.fromMap(x as Map),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthlyData.fromJson(String source) =>
      MonthlyData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MonthlyData(month: $month, daysList: $daysList)';

  @override
  bool operator ==(covariant MonthlyData other) {
    if (identical(this, other)) return true;

    return other.month == month && listEquals(other.daysList, daysList);
  }

  @override
  int get hashCode => month.hashCode ^ daysList.hashCode;
}