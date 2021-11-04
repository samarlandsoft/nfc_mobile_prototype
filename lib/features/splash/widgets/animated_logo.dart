import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/logo_icon.dart';

class AnimatedLogo extends StatefulWidget {
  final bool isVisible;
  final bool isEndAnimation;

  const AnimatedLogo({
    Key? key,
    required this.isVisible,
    required this.isEndAnimation,
  }) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  bool _isPulseStarted = false;

  @override
  void didUpdateWidget(covariant AnimatedLogo oldWidget) {
    if (widget.isEndAnimation) {
      setState(() {
        _isPulseStarted = true;
      });
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        setState(() {
          _isPulseStarted = false;
        });
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logoSize = StyleConstants.kGetLogoHeight(context);

    final logoFinishPosition =
        (mq.size.height / 2.0) - logoSize - mq.viewPadding.top - StyleConstants.kDefaultPadding;
    final logoStartPosition = logoFinishPosition - (mq.size.height * 0.12);

    return AnimatedPositioned(
      duration: const Duration(seconds: 1),
      top: widget.isEndAnimation
          ? 0.0
          : widget.isVisible
              ? logoFinishPosition
              : logoStartPosition,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: _isPulseStarted ? 500 : 1000),
        opacity: _isPulseStarted
            ? 0.2
            : widget.isVisible
                ? 1.0
                : 0.0,
        child: LogoIcon(
          size: logoSize,
        ),
      ),
    );
  }
}
