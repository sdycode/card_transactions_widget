import 'dart:math';

import 'package:transcation_history/lib.dart';

class CalendarGridView extends StatefulWidget {
  final String year;
  final YearData yearData;
  CalendarGridView({
    Key? key,
    required this.year,
    required this.yearData,
  }) : super(key: key);

  @override
  State<CalendarGridView> createState() => _CalendarGridViewState();
}

class _CalendarGridViewState extends State<CalendarGridView> {
  final ScrollController scrollController = ScrollController();
  String year = "2024";
  late final YearData yearData;
  // Start date: January 1st, 2024 (Monday)
  DateTime startDate = DateTime(2024, 1, 1);

  final int totalRows = 7;

  final int totalColumns = 53;
  // Maximum number of weeks in a year
  final List<String> daysOfWeek = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    year = widget.year;
    yearData = widget.yearData;
    startDate = DateTime(int.tryParse(year) ?? 2024, 1, 1);
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = isPortrait(context);
    return isPortrait(context)
        ? LayoutBuilder(builder: (context, box) {
            double fullW = MediaQuery.sizeOf(context).width;
            double margin = min(fullW * 0.03, 4);
            double portBoxSize = min(
                50, (MediaQuery.sizeOf(context).width - margin * 2 * 8) / 8);

            return Column(
              children: [
                // Column for day names (Sun, Mon, Tue, ...)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalRows + 1, (index) {
                    return Container(
                      margin: EdgeInsets.all(margin),
                      width: portBoxSize,
                      height: portBoxSize,
                      alignment: Alignment.center,
                      child: Text(
                        index == 0 ? "Month" : daysOfWeek[index - 1],
                        maxLines: 4,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: portBoxSize * 0.25),
                      ),
                    );
                  }),
                ),

                // Grid with weeks and days

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Scrollbar(
                        controller: scrollController,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        interactive: true,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: List.generate(12, (i) {
                                  return Container(
                                    width: portBoxSize,
                                    height: portBoxSize * 4.25 +
                                        (margin * 2) * 4.25,
                                    alignment: Alignment.center,
                                    child: Text(
                                      shortMonths[i],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  );
                                }),
                              ),
                              Column(
                                children:
                                    List.generate(totalColumns, (weekIndex) {
                                  return Row(
                                    children:
                                        List.generate(totalRows, (dayIndex) {
                                      return DayGridBox(
                                        startDate: startDate,
                                        year: year,
                                        weekIndex: weekIndex,
                                        dayIndex: dayIndex,
                                        portait: portrait,
                                      );
                                    }),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          })
        : Row(
            children: [
              // Row for day names (Sun, Mon, Tue, ...)
              Column(
                children: List.generate(totalRows + 1, (index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.black45,
                    child: Text(
                      index == 0 ? "Month" : daysOfWeek[index - 1],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ),

              // Grid with weeks and days
              Expanded(
                child: Column(
                  children: [
                    Scrollbar(
                      controller: scrollController,
                      scrollbarOrientation: ScrollbarOrientation.bottom,

                      interactive: true,
                      thumbVisibility: true, // Always show the thumb
                      trackVisibility: true, //
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(12, (i) {
                                return Container(
                                  width: 50 * 4.25 + 16 * 4.25,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    months[i],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              }),
                            ),
                            Row(
                              children:
                                  List.generate(totalColumns, (weekIndex) {
                                return Column(
                                  children:
                                      List.generate(totalRows, (dayIndex) {
                                    return DayGridBox(
                                        portait: portrait,
                                        startDate: startDate,
                                        year: year,
                                        weekIndex: weekIndex,
                                        dayIndex: dayIndex);
                                  }),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
