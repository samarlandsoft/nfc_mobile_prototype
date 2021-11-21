import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class AnimatedRipple extends StatelessWidget {
  final double height, width, radius;
  final int count, duration;
  final Color color;
  final bool isRepeated;

  const AnimatedRipple({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
    required this.count,
    this.duration = 2000,
    this.color = StyleConstants.kHyperlinkTextColor,
    this.isRepeated = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RippleAnimation(
        duration: Duration(milliseconds: duration),
        repeat: true,
        color: color,
        minRadius: radius,
        ripplesCount: count,
        child: const SizedBox(),
      ),
    );
  }
}
