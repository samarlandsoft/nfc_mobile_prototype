import 'package:flutter/material.dart';

class SaltCombinedButton extends StatelessWidget {
  final String label;
  final String iconSrc;
  final VoidCallback callback;
  final double? width;
  final Color buttonColor, textButton;

  const SaltCombinedButton({
    Key? key,
    required this.label,
    required this.iconSrc,
    required this.callback,
    this.width,
    this.buttonColor = Colors.transparent,
    this.textButton = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SizedBox(
      width: width ?? mq.size.width * 0.8,
      child: TextButton.icon(
        onPressed: callback,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const ContinuousRectangleBorder(),
          padding: const EdgeInsets.all(14.0),
        ),
        icon: Image.asset(iconSrc),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            color: textButton,
          ),
        ),
      ),
    );
  }
}
