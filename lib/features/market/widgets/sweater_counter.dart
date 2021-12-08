import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class SweaterCounter extends StatelessWidget {
  final int sold, amount;

  const SweaterCounter({
    Key? key,
    required this.sold,
    required this.amount,
  }) : super(key: key);

  static double getCounterSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);
    final textSize = TextPainter(
      text: TextSpan(
        text: 'none',
        style: TextStyle(
          fontSize: isLargeScreen ? 18.0 : 16.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return textSize.height + (StyleConstants.kDefaultPadding * 0.4) * 2.0;
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return Container(
      decoration: const BoxDecoration(
        color: StyleConstants.kSelectedColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: StyleConstants.kDefaultPadding * 0.4,
        horizontal: StyleConstants.kDefaultPadding * 0.8,
      ),
      child: Row(
        children: <Widget>[
          Text(
            sold.toString(),
            style: TextStyle(
              fontSize: isLargeScreen ? 18.0 : 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' / ',
            style: TextStyle(
              fontSize: isLargeScreen ? 18.0 : 16.0,
            ),
          ),
          Text(
            amount.toString(),
            style: TextStyle(
              fontSize: isLargeScreen ? 18.0 : 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
