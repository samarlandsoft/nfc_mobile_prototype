import 'package:flutter/material.dart';

class StyleConstraints {
  static const bottomBarHeight = 56.0;

  static double getLogoHeight(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.2;
  }
}