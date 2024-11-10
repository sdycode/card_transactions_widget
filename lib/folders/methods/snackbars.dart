import 'package:transcation_history/lib.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  ));
}

void showNoTransaction(BuildContext context, DateTime date) {
  showSnackBar(context, 'There is no transaction on ${formatFullDate(date)}}');
}
