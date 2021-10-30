import 'package:flutter/material.dart';

class DialogsWrapper extends StatelessWidget {
  final Widget widget;

  const DialogsWrapper({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: widget,
    );
  }
}
