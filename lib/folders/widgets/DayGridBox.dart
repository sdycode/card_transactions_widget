// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:transcation_history/lib.dart';

class DayGridBox extends StatelessWidget {
  final DateTime startDate;
  final String year;
  final int weekIndex;
  final int dayIndex;
  final bool portait;
  const DayGridBox({
    Key? key,
    required this.startDate,
    required this.year,
    required this.weekIndex,
    required this.dayIndex,
    required this.portait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullW = MediaQuery.sizeOf(context).width;
    double margin = min(fullW * 0.03, 8);
    double portBoxSize =
        min(50, (MediaQuery.sizeOf(context).width - margin * 2 * 8) / 8);
    int totalIndex = weekIndex * 7 + dayIndex;
    return FutureBuilder<Map<String, dynamic>>(
      future: _getBoxData(fullW, margin, startDate, weekIndex, dayIndex, year),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ColorAnimatingBox(
            totalIndex: totalIndex,
            portait: portait,
            portBoxSize: portBoxSize,
            margin: margin,
          ); // Show loading indicator
        }

        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        Map? data = snapshot.data;
        if (data == null) {
          return Container();
        }
        DateTime date = data['date'];
        String dateString = data['dateString'];
        int total = data['total'];
        Color boxColor = data['boxColor'];

        return InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            if (total == 0) {
              showNoTransaction(context, date);
              return;
            }
            List<Transaction> transactions =
                getTransactionsForDay(dateString, year);
            showTransactionsBottomSheet(context, transactions);
          },
          child: Tooltip(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            preferBelow: false,
            message: total != 0
                ? "Total spent:  $total $currency on ${formatDayMonth(date)}"
                : "No transaction.",
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.all(portait ? margin : 8),
              width: portait ? portBoxSize : 50,
              height: portait ? portBoxSize : 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.all(Radius.circular(radius))),
            ),
          ),
        );
      },
    );
  }
}

// Helper method to offload blocking calculations to a background thread
Future<Map<String, dynamic>> _getBoxData(double fullW, double margin,
    DateTime startDate, int weekIndex, int dayIndex, String year) async {
  DateTime date =
      calculateDateForWeekAndDayIndex(startDate, weekIndex, dayIndex);
  String dateString = formatDateWithUnderScore(date);
  int total = getTransactionTotalForDay(dateString, year);
  Color boxColor = getBoxColorForAmount(total);
  await Future.delayed(Duration(milliseconds: 1000));
  return {
    'date': date,
    'dateString': dateString,
    'total': total,
    'boxColor': boxColor,
  };
}
