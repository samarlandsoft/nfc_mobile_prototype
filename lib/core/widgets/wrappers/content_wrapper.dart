import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;

  const ContentWrapper({
    Key? key,
    required this.widget,
  }) : super(key: key);

  static double getWrapperPadding(BuildContext context) {
    final mq = MediaQuery.of(context);
    return StyleConstants.kDefaultPadding + mq.size.width * 0.03;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getWrapperPadding(context),
        0.0,
        getWrapperPadding(context),
        0.0,
      ),
      child: widget,
    );
  }
}
