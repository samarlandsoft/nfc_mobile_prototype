import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class DialogsWrapper extends StatelessWidget {
  final Widget widget;

  const DialogsWrapper({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(StyleConstants.kDefaultPadding),
      child: widget,
    );
  }
}
