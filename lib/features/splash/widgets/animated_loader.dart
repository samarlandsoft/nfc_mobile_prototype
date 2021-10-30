import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

class AnimatedLoader extends AnimatedWidget {
  final double height, width;

  const AnimatedLoader({
    Key? key,
    required Animation<double> animation,
    required this.height,
    required this.width,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value * math.pi,
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset('assets/icons/loader.png'),
      ),
    );
  }
}
