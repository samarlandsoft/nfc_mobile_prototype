import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';

class SaltCircularText extends StatelessWidget {
  const SaltCircularText({Key? key}) : super(key: key);

  static getTextRadius(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.size.width * 0.65 * 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return CircularText(
      radius: getTextRadius(context),
      children: [
        TextItem(
          startAngle: -45,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            'TAP TO SCAN',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        TextItem(
          startAngle: 0,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            '+',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        TextItem(
          startAngle: 45,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            'TAP TO SCAN',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        TextItem(
          startAngle: 90,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            '+',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        TextItem(
          startAngle: 135,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            'TAP TO SCAN',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        TextItem(
          startAngle: -90,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            '+',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        TextItem(
          startAngle: -135,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            'TAP TO SCAN',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        TextItem(
          startAngle: 180,
          startAngleAlignment: StartAngleAlignment.center,
          text: const Text(
            '+',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}
