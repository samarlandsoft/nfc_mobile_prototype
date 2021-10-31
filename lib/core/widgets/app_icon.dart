import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double height, width;

  const AppIcon({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset('assets/icons/icon.png'),
    );
  }
}
