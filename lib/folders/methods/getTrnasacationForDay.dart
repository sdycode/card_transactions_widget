import 'package:transcation_history/lib.dart';

List<Transaction> getTransactionsForDay(String dateString, String year) {
  if (!DataService.instance.allYearsDateWiseData.containsKey(year)) {
    DataService.instance.allYearsDateWiseData[year] =
        DateWiseDataInYear(year: year);
  }

  DateWiseDataInYear yearData =
      DataService.instance.allYearsDateWiseData[year]!;

  if (yearData.transactionsByDay.containsKey(dateString)) {
    return yearData.transactionsByDay[dateString]!;
  }

  if (DataService.instance.allYearsData.containsKey(year)) {
    YearData yearDataInAllYears = DataService.instance.allYearsData[year]!;

    List<Transaction> transactions = [];
    for (MonthlyData monthData in yearDataInAllYears.monthlyDataList) {
      for (DayData dayData in monthData.daysList) {
        String dayDateString = formatDateWithUnderScore(
          DateTime(int.tryParse(year) ?? 2024, monthData.month, dayData.day),
        );

        if (dayDateString == dateString) {
          transactions = dayData.transactions;
          break;
        }
      }
    }

    yearData.transactionsByDay[dateString] = transactions;

    return transactions;
  }

  return [];
}
