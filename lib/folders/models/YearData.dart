
import 'package:transcation_history/lib.dart';

class YearData {
  String year;
  List<MonthlyData> monthlyDataList;
  YearData({
    required this.year,
    required this.monthlyDataList,
  });

  YearData copyWith({
    String? year,
    List<MonthlyData>? monthlyDataList,
  }) {
    return YearData(
      year: year ?? this.year,
      monthlyDataList: monthlyDataList ?? this.monthlyDataList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'year': year,
      'monthlyDataList': monthlyDataList.map((x) => x.toMap()).toList(),
    };
  }

  factory YearData.fromMap(Map<String, dynamic> map) {
    return YearData(
      year: map['year'] as String,
      monthlyDataList: List<MonthlyData>.from(
        ((map['monthlyDataList'] ?? []) as List).map<MonthlyData>(
          (x) => MonthlyData.fromMap(x as Map),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory YearData.fromJson(String source) =>
      YearData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'YearData(year: $year, monthlyDataList: $monthlyDataList)';

  @override
  bool operator ==(covariant YearData other) {
    if (identical(this, other)) return true;

    return other.year == year &&
        listEquals(other.monthlyDataList, monthlyDataList);
  }

  @override
  int get hashCode => year.hashCode ^ monthlyDataList.hashCode;
}
