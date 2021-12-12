import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final bool withViewTopPadding;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.withViewTopPadding = false,
  }) : super(key: key);

  static double getTopPadding(BuildContext context) {
    return StyleConstants.kGetScreenRatio(context)
        ? StyleConstants.kDefaultPadding * 2.0
        : StyleConstants.kDefaultPadding;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.03;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        StyleConstants.kDefaultPadding + horizontalPadding,
        withViewTopPadding ? mq.viewPadding.top : getTopPadding(context),
        StyleConstants.kDefaultPadding + horizontalPadding,
        0.0,
      ),
      child: widget,
    );
  }
}
