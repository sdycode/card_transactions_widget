import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:transcation_history/lib.dart';
void main() {
  group('YearData Model', () {
    final monthlyDataList = [
      MonthlyData(month: 1, daysList: []),
      MonthlyData(month: 2, daysList: []),
      // Additional months can be added here
    ];
    final sampleYearData =
        YearData(year: "2024", monthlyDataList: monthlyDataList);

    test('fromJson should deserialize JSON to correct YearData object', () {
      final jsonString = jsonEncode({
        'year': '2024',
        'monthlyDataList': monthlyDataList.map((m) => m.toJson()).toList(),
      });
      final yearData = YearData.fromJson(jsonString);

      expect(yearData.year, '2024');
      expect(yearData.monthlyDataList.length, monthlyDataList.length);
    });

    test('toMap should convert YearData to correct map format', () {
      final map = sampleYearData.toMap();

      expect(map['year'], '2024');
      expect(map['monthlyDataList'], isA<List>());
      expect(map['monthlyDataList'].length, monthlyDataList.length);
    });

    test('fromMap should convert map to correct YearData object', () {
      final map = {
        'year': '2024',
        'monthlyDataList': monthlyDataList.map((m) => m.toMap()).toList(),
      };
      final yearData = YearData.fromMap(map);

      expect(yearData.year, '2024');
      expect(yearData.monthlyDataList.length, monthlyDataList.length);
    });

    test('copyWith should create a modified copy of YearData', () {
      final modifiedYearData = sampleYearData.copyWith(year: '2025');

      expect(modifiedYearData.year, '2025');
      expect(modifiedYearData.monthlyDataList, monthlyDataList);
    });

    test(
        'Equality operator should compare YearData objects based on properties',
        () {
      final anotherYearData = YearData(
        year: '2024',
        monthlyDataList: monthlyDataList,
      );

      expect(sampleYearData, anotherYearData);
      expect(sampleYearData.hashCode, anotherYearData.hashCode);
    });

    test('Handling of YearData with no monthly data (boundary test)', () {
      final emptyYearData = YearData(year: '2024', monthlyDataList: []);

      expect(emptyYearData.monthlyDataList, isEmpty);
    });
  });
}
