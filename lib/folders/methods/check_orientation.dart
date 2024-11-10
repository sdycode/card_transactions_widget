

import 'package:flutter/widgets.dart';

bool isPortrait(BuildContext context) {
  // Check if the window is in portrait mode
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

bool isLandscape(BuildContext context) {
  // Check if the window is in landscape mode
  return MediaQuery.of(context).orientation == Orientation.landscape;
}