import 'package:flutter/material.dart';

class SaltIconButton extends StatelessWidget {
  final String iconSrc;
  final VoidCallback callback;
  final double? size;

  const SaltIconButton({
    Key? key,
    required this.iconSrc,
    required this.callback,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 30.0,
      width: size ?? 30.0,
      child: GestureDetector(
        onTap: callback,
        child: Image.asset(iconSrc),
      ),
    );
  }
}
