import 'package:flutter/material.dart';

class AnimatedPulse extends StatefulWidget {
  final double height, width;

  const AnimatedPulse({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _AnimatedPulseState createState() => _AnimatedPulseState();
}

class _AnimatedPulseState extends State<AnimatedPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.scale(
          scale: 0.8 + (_controller.value * 0.5),
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Image.asset('assets/icons/pulse.png'),
          ),
        );
      },
    );
  }
}
