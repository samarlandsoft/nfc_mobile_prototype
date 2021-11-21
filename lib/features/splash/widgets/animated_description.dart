import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class AnimatedDescription extends StatefulWidget {
  final bool isVisible;
  final bool isEndAnimation;

  const AnimatedDescription({
    Key? key,
    required this.isVisible,
    required this.isEndAnimation,
  }) : super(key: key);

  @override
  State<AnimatedDescription> createState() => _AnimatedDescriptionState();
}

class _AnimatedDescriptionState extends State<AnimatedDescription> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logoSize = StyleConstants.kGetLogoHeight(context);
    final descriptionHeight = mq.size.width * 0.2;
    final descriptionWidth = mq.size.width * 0.7;

    final descriptionFinishPosition =
        (mq.size.height / 2.0) + StyleConstants.kDefaultPadding;
    final descriptionStartPosition =
        descriptionFinishPosition + (mq.size.height * 0.12);

    return AnimatedPositioned(
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      top: widget.isEndAnimation
          ? logoSize + (StyleConstants.kDefaultPadding * 1.5)
          : widget.isVisible
              ? descriptionFinishPosition
              : descriptionStartPosition,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000),
        opacity: widget.isVisible ? 1.0 : 0.0,
        child: SizedBox(
          width: descriptionWidth,
          child: const Text(
            'Connection physical to metaverse',
            style: TextStyle(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
