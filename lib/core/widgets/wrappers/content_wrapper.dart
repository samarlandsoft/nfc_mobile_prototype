import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final bool withVerticalPadding;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.withVerticalPadding = false,
  }) : super(key: key);

  static double getWrapperPadding(BuildContext context) {
    final mq = MediaQuery.of(context);
    return StyleConstants.kDefaultPadding + mq.size.width * 0.03;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: withVerticalPadding ? getWrapperPadding(context) : 0.0,
        bottom: withVerticalPadding ? getWrapperPadding(context) : 0.0,
        left: getWrapperPadding(context),
        right: getWrapperPadding(context),
      ),
      child: widget,
    );
  }
}
