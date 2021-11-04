import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/widgets/app_icon.dart';

class AnimatedAppIcon extends StatelessWidget {
  final bool isVisible;

  const AnimatedAppIcon({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final iconSize = mq.size.width * 0.25;
    final iconPosition = (mq.size.height / 2.0) -
        (iconSize / 2.0) -
        (mq.viewPadding.top * 0.5);

    return Positioned(
      bottom: iconPosition,
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: isVisible ? 0.0 : 1.0,
        child: AppIcon(
          height: iconSize,
          width: iconSize,
        ),
      ),
    );
  }
}
