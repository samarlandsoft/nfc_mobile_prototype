import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final bool isTapped;
  final VoidCallback callback;

  const RoundedButton({
    Key? key,
    required this.icon,
    required this.isTapped,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonSize = 60.0;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isTapped
            ? Colors.orange.withOpacity(0.3)
            : Colors.grey.withOpacity(0.3),
        side: BorderSide(
          color: isTapped ? Colors.orange : Colors.grey,
          width: 4.0,
        ),
        fixedSize: const Size(buttonSize, buttonSize),
        shape: const CircleBorder(),
      ),
      onPressed: callback,
      child: Icon(
        icon,
        size: buttonSize * 0.5,
        color: isTapped ? Colors.orange : Colors.grey,
      ),
    );
  }
}
