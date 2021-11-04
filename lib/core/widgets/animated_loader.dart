import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedLoader extends StatefulWidget {
  final double height, width;

  const AnimatedLoader({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _AnimatedLoaderState createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<AnimatedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.rotate(
          angle: _controller.value * math.pi,
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Image.asset('assets/icons/loader.png'),
          ),
        );
      },
    );
  }
}
