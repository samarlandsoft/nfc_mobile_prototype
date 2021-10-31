import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  final double size;

  const LogoIcon({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logoWidth = MediaQuery.of(context).size.width * 0.75;

    return SizedBox(
      height: size,
      width: logoWidth,
      child: Image.asset('assets/icons/logo.png'),
    );
  }
}
