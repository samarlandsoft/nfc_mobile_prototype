import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/widgets/app_icon.dart';

class AnimatedAppIcon extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final iconSize = mq.size.width * 0.25;
    final iconPosition =
        (mq.size.height / 2.0) - (iconSize / 2.0) - (mq.viewPadding.top * 0.5);

    return withPosition
        ? Positioned(
            bottom: iconPosition,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: duration),
              opacity: isVisible
                  ? isPulsed
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
            duration: Duration(milliseconds: duration),
            opacity: isVisible
                ? isPulsed
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
