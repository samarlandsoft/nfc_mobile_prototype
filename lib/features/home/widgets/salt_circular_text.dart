import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class SaltAnimatedCircularText extends StatefulWidget {
  const SaltAnimatedCircularText({Key? key}) : super(key: key);

  static getTextRadius(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.size.width * 0.65 * 0.5;
  }

  @override
  State<SaltAnimatedCircularText> createState() =>
      _SaltAnimatedCircularTextState();
}

class _SaltAnimatedCircularTextState extends State<SaltAnimatedCircularText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: StyleConstants.kGetScreenRatio(context) ? 20.0 : 18.0,
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.rotate(
          angle: _controller.value * math.pi,
          child: _SaltCircularText(
            radius: SaltAnimatedCircularText.getTextRadius(context),
            style: textStyle,
          ),
        );
      },
    );
  }
}

class _SaltCircularText extends StatelessWidget {
  final double radius;
  final TextStyle style;

  const _SaltCircularText({
    Key? key,
    required this.radius,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularText(
      radius: radius,
      children: [
        TextItem(
          startAngle: -45,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: style,
          ),
        ),
        TextItem(
          startAngle: 0,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: style,
          ),
        ),
        TextItem(
          startAngle: 45,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: style,
          ),
        ),
        TextItem(
          startAngle: 90,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: style,
          ),
        ),
        TextItem(
          startAngle: 135,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: style,
          ),
        ),
        TextItem(
          startAngle: -90,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: style,
          ),
        ),
        TextItem(
          startAngle: -135,
          space: 6.5,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            'TAP TO SCAN',
            style: style,
          ),
        ),
        TextItem(
          startAngle: 180,
          startAngleAlignment: StartAngleAlignment.center,
          text: Text(
            '+',
            style: style,
          ),
        ),
      ],
    );
  }
}
