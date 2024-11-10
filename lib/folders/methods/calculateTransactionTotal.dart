import 'package:transcation_history/lib.dart';

int calculateTotalAmount(List<Transaction> transactions) {
  return transactions.fold(0, (sum, transaction) {
    if (transaction.type == TransactionType.debit) {
      return sum + transaction.amount.round(); // Add debit amounts
    } else {
      return sum - transaction.amount.round(); // Subtract credit amounts
    }
  });
}

int getTransactionTotalForDay(String dateString, String year) {
  // Check if the data for the year is already present
  if (!DataService.instance.allYearsDateWiseData.containsKey(year)) {
    // If not, create a new DateWiseDataInYear and populate it using YearData
    DataService.instance.allYearsDateWiseData[year] =
        DateWiseDataInYear(year: year);

    // Populate DateWiseDataInYear from YearData
    DateWiseDataInYear dateWiseDataInYear =
        DataService.instance.allYearsDateWiseData[year]!;

    // Fetch data from YearData and fill in the transactionsByDay map
    YearData yearData = DataService.instance.allYearsData[
        year]!; // Assuming allYearsData contains the full YearData object

    for (MonthlyData monthlyData in yearData.monthlyDataList) {
      for (DayData dayData in monthlyData.daysList) {
        String dateKey =
            '${dayData.day.toString().padLeft(2, '0')}_${monthlyData.month.toString().padLeft(2, '0')}_$year';
        dateWiseDataInYear.transactionsByDay[dateKey] = dayData.transactions;
      }
    }
  }

  // Now that DateWiseDataInYear is populated, proceed with checking the transaction totals
  DateWiseDataInYear dateWiseDataInYear =
      DataService.instance.allYearsDateWiseData[year]!;

  // Check if the transaction total for the day is already calculated
  if (dateWiseDataInYear.transactionTotals.containsKey(dateString)) {
    return dateWiseDataInYear.transactionTotals[dateString]!;
  }

  // If transaction total is not calculated, compute it and save it
  if (dateWiseDataInYear.transactionsByDay.containsKey(dateString)) {
    int total = dateWiseDataInYear.transactionsByDay[dateString]!.fold(0,
        (sum, transaction) {
      if (transaction.type == TransactionType.debit) {
        return sum + transaction.amount.round(); // Add debit amounts
      } else {
        return sum - transaction.amount.round(); // Subtract credit amounts
      }
    });

    dateWiseDataInYear.transactionTotals[dateString] = total;

    return total;
  }

  // Return 0 if there are no transactions for the specified day
  return 0;
}
