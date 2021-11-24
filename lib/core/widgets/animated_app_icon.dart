import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/widgets/app_icon.dart';

class AnimatedAppIcon extends StatefulWidget {
  final bool isVisible;
  final bool isPulsed;
  final bool withPosition;
  final int duration;

  const AnimatedAppIcon({
    Key? key,
    required this.isVisible,
    this.isPulsed = false,
    this.withPosition = true,
    this.duration = 1000,
  }) : super(key: key);

  @override
  State<AnimatedAppIcon> createState() => _AnimatedAppIconState();
}

class _AnimatedAppIconState extends State<AnimatedAppIcon> {
  final int _animationDuration = 1000;
  Timer? _timer;
  bool _isPulsed = false;

  @override
  void didChangeDependencies() {
    if (widget.isPulsed) {
      _playAnimation(_animationDuration);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _playAnimation(int duration) {
    Future.delayed(Duration(milliseconds: duration)).then((_) {
      _timer = Timer.periodic(Duration(milliseconds: duration), (_) {
        setState(() {
          _isPulsed = !_isPulsed;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final iconSize = mq.size.width * 0.24;
    final iconPosition =
        (mq.size.height / 2.0) - (iconSize / 2.0) - (mq.viewPadding.vertical * 0.3);

    return widget.withPosition
        ? Positioned(
            bottom: iconPosition,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: widget.duration),
              opacity: widget.isVisible
                  ? _isPulsed
                      ? 0.7
                      : 1.0
                  : 0.0,
              child: AppIcon(
                height: iconSize,
                width: iconSize,
              ),
            ),
          )
        : AnimatedOpacity(
            duration: Duration(milliseconds: widget.duration),
            opacity: widget.isVisible
                ? _isPulsed
                    ? 0.7
                    : 1.0
                : 0.0,
            child: AppIcon(
              height: iconSize,
              width: iconSize,
            ),
          );
  }
}
