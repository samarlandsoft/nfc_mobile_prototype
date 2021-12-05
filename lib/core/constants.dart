import 'package:flutter/material.dart';

class StyleConstants {
  static const kDefaultPadding = 10.0;
  static const TextStyle kDefaultTextStyle = TextStyle(
    fontSize: 18.0,
    fontFamily: 'Montserrat',
  );
  static const kDefaultButtonSize = 60.0;

  static const kBackgroundColor = Color(0xFF141414);
  static const kHyperLinkColor = Colors.blueAccent;
  static const kSelectedColor = Colors.pink;
  static const kMarketColor = Colors.deepPurple;
  static const kInactiveColor = Colors.grey;

  static Color kGetLightColor() {
    return Colors.grey[50]!;
  }

  static Color kGetDarkColor() {
    return Colors.grey[850]!;
  }
}