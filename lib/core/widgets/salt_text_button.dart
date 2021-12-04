import 'package:flutter/material.dart';

class SaltTextButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final double? width;
  final Color buttonColor, textButton;

  const SaltTextButton({
    Key? key,
    required this.label,
    required this.callback,
    this.width,
    this.buttonColor = Colors.black,
    this.textButton = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SizedBox(
      width: width ?? mq.size.width * 0.8,
      child: TextButton(
        onPressed: callback,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const ContinuousRectangleBorder(),
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        ),
        child: Text(
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
