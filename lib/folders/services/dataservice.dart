import 'package:transcation_history/lib.dart';

class DataService {
  // Singleton pattern for DataService
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();
  // Data caches
  final Map<String, YearData?> _allYearsData = {};
  final Map<String, DateWiseDataInYear> _allYearsDateWiseData = {};

  // Getter for allYearsData
  Map<String, YearData?> get allYearsData => _allYearsData;

  // Setter for allYearsData
  void setYearData(String year, YearData data) {
    _allYearsData[year] = data;
  }

  // Getter for allYearsDateWiseData
  Map<String, DateWiseDataInYear> get allYearsDateWiseData =>
      _allYearsDateWiseData;

  // Setter for allYearsDateWiseData
  void setDateWiseData(String date, DateWiseDataInYear data) {
    _allYearsDateWiseData[date] = data;
  }

  // Method to load JSON data lazily
  Future<YearData?> loadYearlyTransactions(String year) async {
    // Check if data is already loaded and cached
    if (_allYearsData[year] != null &&
        _allYearsData[year]!.monthlyDataList.isNotEmpty) {
      return _allYearsData[year];
    }

    try {
      // Load data using your existing method
      YearData? data = await loadYearlyTransactionsJson(year);
      _allYearsData[year] = data; // Cache the loaded data
      return data;
    } catch (e) {
      debugPrint("Error loading yearly transactions: $e");
      return null;
    }
  }

  /// Wrapper function to use compute for isolate processing.
  Future<YearData?> loadYearlyTransactionsJson(String year) async {
    if (allYearsData[year] != null &&
        allYearsData[year]!.monthlyDataList.isNotEmpty) {
      return allYearsData[year]!;
    }
    YearData? data;
    if (kIsWeb) {
      data = await compute<String, YearData?>(loadJsonInIsolate, year);
    } else {
      data = await loadJsonInIsolate(year);
    }

    if (data != null) {
      allYearsData[year] = data;
    }
    print(" allYearsData[year] ${allYearsData[year] != null}");
    return data;
  }

  Future<bool> loadCompleteData() async {
    if (DataService.instance.allYearsData.length>=3) {
      return true;
    }
    await Future.forEach(DataService.instance.dataFilePaths.keys.toList(),
        (year) async {
      await loadYearlyTransactionsJson(year);
    });
    return true;
  }

  /// Function to be executed in an isolate to load and parse JSON file.
  Future<YearData?> loadJsonInIsolate(String year) async {
    try {
      // Load JSON file from assets as a string
      final String jsonString = await rootBundle
          .loadString((kIsWeb ? "" : "assets/") + dataFilePaths[year]!);
      debugPrint("jsonString ${jsonDecode(jsonString).runtimeType}");
      // Parse the JSON string into a Map
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      allYearsData[year] = YearData.fromMap(jsonData);
      return allYearsData[year];
    } catch (e) {
      debugPrint("jsonString errr ${e}");
      throw Exception("Failed to load or parse JSON file: $e");
    }
  }

  Map<String, String> dataFilePaths = {
    "2024": "yearly_transactions_2024.json",
    "2023": "yearly_transactions_2023.json",
    "2022": "yearly_transactions_2022.json",
  };
}
