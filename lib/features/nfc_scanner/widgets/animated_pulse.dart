import 'package:flutter/cupertino.dart';

class AnimatedPulse extends AnimatedWidget {
  final double height, width;

  const AnimatedPulse({
    Key? key,
    required Animation<double> animation,
    required this.height,
    required this.width,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: 0.8 + (animation.value * 0.5),
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset('assets/icons/pulse.png'),
      ),
    );
  }
}
