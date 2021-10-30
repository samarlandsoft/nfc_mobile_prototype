import 'dart:ui';

import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;

  const NeonButton({
    Key? key,
    required this.label,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Colors.orange,
          width: 4.0,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      onPressed: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}
