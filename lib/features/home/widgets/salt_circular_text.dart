import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class SaltCircularText extends StatelessWidget {
  const SaltCircularText({Key? key}) : super(key: key);

  static getTextRadius(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.size.width * 0.65 * 0.5;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: StyleConstants.kGetScreenRatio(context) ? 20.0 : 18.0,
    );

    return CircularText(
      radius: getTextRadius(context),
      children: [
        TextItem(
          startAngle: -45,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: textStyle,
          ),
        ),
        TextItem(
          startAngle: 0,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: textStyle,
          ),
        ),
        TextItem(
          startAngle: 45,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: textStyle,
          ),
        ),
        TextItem(
          startAngle: 90,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: textStyle,
          ),
        ),
        TextItem(
          startAngle: 135,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: textStyle,
          ),
        ),
        TextItem(
          startAngle: -90,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: textStyle,
          ),
        ),
        TextItem(
          startAngle: -135,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: textStyle,
          ),
        ),
        TextItem(
          startAngle: 180,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
