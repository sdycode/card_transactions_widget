import 'package:transcation_history/lib.dart';

double radius = 12;
bool isLargeDevice(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  double height = MediaQuery.sizeOf(context).height;
  bool isLandscape = width > height;

  return (width > 600 || (isLandscape && width > height));
}

updateRadius(BuildContext context) {
  radius = isLargeDevice(context) ? 12 : 8;
}
