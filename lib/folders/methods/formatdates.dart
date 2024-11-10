


String formatDateWithUnderScore(DateTime date) {
  String day =
      date.day.toString().padLeft(2, '0'); // Ensures two digits for day
  String month =
      date.month.toString().padLeft(2, '0'); // Ensures two digits for month
  String year = date.year.toString();

  return "${day}_${month}_$year";
}

final List<String> weekDays = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
];

final List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];final List<String> shortMonths = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

String formatFullDate(DateTime date) {
  // Weekdays and months lists

  // Get the day of the week, day of the month, month name, and year
  String weekdayName = weekDays[date.weekday - 1];
  int dayOfMonth = date.day;
  String monthName = months[date.month - 1];
  int year = date.year;

  // Combine everything into the full date string
  return '$weekdayName, $dayOfMonth $monthName $year';
}

String formatDayMonth(DateTime date) {
  // Weekdays and months lists

  // Get the day of the week, day of the month, month name, and year
  int dayOfMonth = date.day;
  String monthName = months[date.month - 1];

  // Combine everything into the full date string
  return '$dayOfMonth $monthName';
}
DateTime calculateDateForWeekAndDayIndex(
  DateTime startDate,
  int weekIndex,
  int dayIndex,
) {
  // Calculate the date for the current day in the grid
  int daysToAdd = weekIndex * 7 + dayIndex - startDate.weekday + 1 - 1;
  DateTime date = startDate.add(Duration(days: daysToAdd));
  return date;
}
String formatTimeAMPM(DateTime dateTime) {
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = hour >= 12 ? 'PM' : 'AM';

  // Convert to 12-hour format
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Adjust for 12 PM and 12 AM

  // Format minute with leading zero if needed
  String minuteStr = minute.toString().padLeft(2, '0');

  return '$hour:$minuteStr $period';
}