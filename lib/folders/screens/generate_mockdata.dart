// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:html' as html;
import 'dart:math';

import 'package:transcation_history/lib.dart';

class GenerateMockDataPage extends StatefulWidget {
  const GenerateMockDataPage({super.key});

  @override
  State<GenerateMockDataPage> createState() => _GenerateMockDataPageState();
}

class _GenerateMockDataPageState extends State<GenerateMockDataPage> {
  int year = 2022;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(3, (i) {
                year = [2022, 2023, 2024][i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        year = [2022, 2023, 2024][i];
                        YearData yearlyData =
                            generateYearlyTransactionData(year);

                        debugPrint("larg ${yearlyData.monthlyDataList.length}");

                        downloadJsonFile(yearlyData.toJson(), year);
                      },
                      child: Text("Generate $year ")),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
} // Function to save JSON file in Flutter Web

void downloadJsonFile(String jsonString, int year) {
  // Create a Blob from the JSON string
  final blob = html.Blob([jsonString]);

  // Create an anchor element
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..target = 'blank'
    ..download = 'yearly_transactions_$year.json';

  // Trigger the download
  anchor.click();

  // Revoke the URL after download to free resources
  html.Url.revokeObjectUrl(url);
}

YearData generateYearlyTransactionData(int year) {
  Random random = Random();
  List<MonthlyData> monthlyDataList = [];

  for (int month = 1; month <= 12; month++) {
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<DayData> daysList = [];

    // Step 1: Randomly select credit and debit surplus days
    Set<int> creditSurplusDays = {};
    Set<int> debitSurplusDays = {};

    // Select 3-4 random days for credit surplus
    int creditDaysCount = random.nextInt(2) + 3; // 3 to 4 days
    while (creditSurplusDays.length < creditDaysCount) {
      creditSurplusDays.add(random.nextInt(daysInMonth) + 1);
    }

    // Select 18-22 random days for debit surplus
    int debitDaysCount = random.nextInt(5) + 18; // 18 to 22 days
    while (debitSurplusDays.length < debitDaysCount) {
      int day = random.nextInt(daysInMonth) + 1;
      if (!creditSurplusDays.contains(day)) {
        debitSurplusDays.add(day);
      }
    }

    // Step 2: Generate transactions for each day in the month
    for (int day = 1; day <= daysInMonth; day++) {
      List<Transaction> transactions = [];

      // Generate transactions for credit surplus days
      if (creditSurplusDays.contains(day)) {
        int transactionCount = random.nextInt(20) + 5; // 5-25 transactions
        double totalCredit = 0;
        double totalDebit = 0;

        for (int i = 0; i < transactionCount; i++) {
          int amount = random.nextInt(200) + 1;
          TransactionType type = (random.nextDouble() < 0.7)
              ? TransactionType.credit
              : TransactionType.debit; // 70% credit transactions
          if (type == TransactionType.credit) {
            totalCredit += amount;
          } else {
            totalDebit += amount;
          }

          Category category =
              Category.values[random.nextInt(Category.values.length)];
          Subcategory subcategory = getRandomSubcategoryForCategory(category);
          String description = "${subcategory.name} transaction";

          transactions.add(Transaction(
            date: DateTime(year, month, day),
            amount: amount,
            type: type,
            category: category,
            subcategory: subcategory,
            description: description,
          ));
        }

        // Ensure credit surplus
        if (totalDebit >= totalCredit) {
          double adjustment =
              totalDebit - totalCredit + random.nextInt(50) + 10;
          totalCredit += adjustment;
          transactions.add(Transaction(
            date: DateTime(year, month, day),
            amount: adjustment.toInt(),
            type: TransactionType.credit,
            category: Category.miscellaneous,
            subcategory:
                getRandomSubcategoryForCategory(Category.miscellaneous),
            description: "Credit adjustment",
          ));
        }
      }

      // Generate transactions for debit surplus days
      else if (debitSurplusDays.contains(day)) {
        int transactionCount = random.nextInt(20) + 5; // 5-25 transactions
        double totalDebit = 0;
        double totalCredit = 0;

        for (int i = 0; i < transactionCount; i++) {
          int amount = random.nextInt(200) + 1;
          TransactionType type = (random.nextDouble() < 0.7)
              ? TransactionType.debit
              : TransactionType.credit; // 70% debit transactions
          if (type == TransactionType.debit) {
            totalDebit += amount;
          } else {
            totalCredit += amount;
          }

          Category category =
              Category.values[random.nextInt(Category.values.length)];
          Subcategory subcategory = getRandomSubcategoryForCategory(category);
          String description = "${subcategory.name} transaction";

          transactions.add(Transaction(
            date: DateTime(year, month, day),
            amount: amount,
            type: type,
            category: category,
            subcategory: subcategory,
            description: description,
          ));
        }

        // Ensure debit surplus
        if (totalCredit >= totalDebit) {
          double adjustment =
              totalCredit - totalDebit + random.nextInt(50) + 10;
          totalDebit += adjustment;
          transactions.add(Transaction(
            date: DateTime(year, month, day),
            amount: adjustment.toInt(),
            type: TransactionType.debit,
            category: Category.miscellaneous,
            subcategory:
                getRandomSubcategoryForCategory(Category.miscellaneous),
            description: "Debit adjustment",
          ));
        }
      }

      // Add the day data (with or without transactions)
      daysList.add(DayData(day: day, transactions: transactions));
    }

    // Add MonthlyData for each month
    monthlyDataList.add(MonthlyData(month: month, daysList: daysList));
  }

  YearData yearlyData =
      YearData(year: "2024", monthlyDataList: monthlyDataList);
  return yearlyData;
}

DateTime generateRandomDateTime(int year, int month, int day) {
  final random = Random();

  // Generate random hours (0 to 23), minutes (0 to 59), and seconds (0 to 59)
  int hour = random.nextInt(24);
  int minute = random.nextInt(60);
  int second = random.nextInt(60);

  // Create a DateTime with the generated random time
  return DateTime(year, month, day, hour, minute, second);
}
