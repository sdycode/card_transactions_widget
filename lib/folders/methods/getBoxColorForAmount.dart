import 'package:transcation_history/lib.dart';

Color getBoxColorForAmount(int amount) {
  if (amount >= 10000) {
    return Colors.green.shade900;
  } else if (amount >= 7500) {
    return Colors.green.shade800;
  } else if (amount >= 5000) {
    return Colors.green.shade700;
  } else if (amount >= 2500) {
    return Colors.green.shade600;
  } else if (amount >= 1000) {
    return Colors.green.shade500;
  } else if (amount >= 500) {
    return Colors.green.shade400;
  } else if (amount >= 250) {
    return Colors.green.shade300;
  } else if (amount > 0) {
    return Colors.green.shade200;
  } else if (amount == 0) {
    return Colors.white12;
  } else if (amount <= -10000) {
    return Colors.red.shade900;
  } else if (amount <= -7500) {
    return Colors.red.shade800;
  } else if (amount <= -5000) {
    return Colors.red.shade700;
  } else if (amount <= -2500) {
    return Colors.red.shade600;
  } else if (amount <= -1000) {
    return Colors.red.shade500;
  } else if (amount <= -500) {
    return Colors.red.shade400;
  } else if (amount <= -250) {
    return Colors.red.shade300;
  } else {
    return Colors.red.shade200;
  }
}
