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

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.03;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        StyleConstants.kDefaultPadding + horizontalPadding,
        withViewTopPadding ? mq.viewPadding.top : 0.0,
        StyleConstants.kDefaultPadding + horizontalPadding,
        0.0,
      ),
      child: widget,
    );
  }
}
