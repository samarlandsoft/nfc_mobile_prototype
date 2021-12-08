import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final EdgeInsets? padding;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.03;

    return Padding(
      padding: padding ??
          EdgeInsets.fromLTRB(
            StyleConstants.kDefaultPadding + horizontalPadding,
            StyleConstants.kGetScreenRatio(context)
                ? StyleConstants.kDefaultPadding * 2.0
                : StyleConstants.kDefaultPadding,
            StyleConstants.kDefaultPadding + horizontalPadding,
            0.0,
          ),
      child: widget,
    );
  }
}
