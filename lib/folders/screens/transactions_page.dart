// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:transcation_history/lib.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String currentYear = "2024";

  DateTime get now => DateTime.now();
  int diff(DateTime date) {
    return (date.millisecondsSinceEpoch - now.millisecondsSinceEpoch).abs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Credit Card Transactions",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                const Text("Select Year"),
                const SizedBox(
                  width: 12,
                ),
                ...List.generate(3, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: RawChip(
                      label: Text(
                          DataService.instance.dataFilePaths.keys.toList()[i]),
                      selected: currentYear ==
                          DataService.instance.dataFilePaths.keys.toList()[i],
                      onSelected: (isSelected) {
                        setState(() {
                          currentYear = DataService.instance.dataFilePaths.keys
                              .toList()[i];
                        });
                      },
                      selectedColor: Colors
                          .blueAccent, // Highlight color for the selected chip
                      backgroundColor: Colors
                          .grey[300], // Background color for unselected chips
                      labelStyle: TextStyle(
                        color: currentYear ==
                                DataService.instance.dataFilePaths.keys
                                    .toList()[i]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }),
              ],
            ),
            Expanded(
              child: FutureBuilder<bool>(
                future: loadData(),
                builder: (context, snapshot) {
                  // Loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  // Error state
                  if (snapshot.hasError) {
                    debugPrint("err ${snapshot.error}");
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Error loading data',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    );
                  }

                  // Success state
                  if (snapshot.hasData &&
                      DataService.instance.allYearsData[currentYear] != null) {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Expanded(
                          child: CalendarGridView(
                            year: currentYear,
                            yearData:
                                DataService.instance.allYearsData[currentYear]!,
                          ),
                        )
                      ],
                    );
                  }

                  // Default state (this shouldn't be reached)
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator.adaptive(),
                      Text('Please wait'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
