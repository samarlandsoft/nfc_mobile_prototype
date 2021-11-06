import 'package:flutter/material.dart';

class StyleConstants {
  static const kDefaultPadding = 10.0;
  static const kBottomBarHeight = 56.0;

  static const kBackgroundColor = Color(0xFF141414);
  static const kSelectedTextColor = Colors.pink;
  static const kHyperlinkTextColor = Colors.blue;

  static Color kGetLightColor() {
    return Colors.grey[50]!;
  }

  static Color kGetDarkColor() {
    return Colors.grey[850]!;
  }

  static double kGetLogoHeight(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.2;
  }
}