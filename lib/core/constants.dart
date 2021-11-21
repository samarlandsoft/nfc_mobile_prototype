import 'package:flutter/material.dart';

class StyleConstants {
  static const kDefaultPadding = 10.0;
  static const kBottomBarHeight = 56.0;

  static const kBackgroundColor = Color(0xFF141414);
  static const kPrimaryColor = Colors.orange;
  static const kSelectedTextColor = Colors.pink;
  static const kHyperlinkTextColor = Colors.blue;

  static const kBTCColor = Color(0xFFF7931A);
  static const kETHColor = Color(0xFF4CC9F0);

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