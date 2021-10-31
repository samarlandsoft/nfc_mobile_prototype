import 'package:flutter/material.dart';

class AnimatedDescription extends StatefulWidget {
  final bool isVisible;

  const AnimatedDescription({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  _AnimatedDescriptionState createState() => _AnimatedDescriptionState();
}

class _AnimatedDescriptionState extends State<AnimatedDescription>
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
    final mq = MediaQuery.of(context);
    final descriptionHeight = mq.size.width * 0.2;
    final descriptionWidth = mq.size.width * 0.7;

    final descriptionFinishPosition = (mq.size.height / 2.0) -
        descriptionHeight -
        mq.viewPadding.top -
        10.0;
    final descriptionStartPosition =
        descriptionFinishPosition - (mq.size.height * 0.12);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final textOpacityPulse =
        _controller.value < 0.9 ? _controller.value + 0.1 : _controller.value;

        return AnimatedPositioned(
          duration: const Duration(seconds: 1),
          bottom: widget.isVisible ? descriptionFinishPosition : descriptionStartPosition,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: widget.isVisible ? textOpacityPulse : 0.0,
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
      },
    );
  }
}

// class AnimatedDescription extends StatelessWidget {
//   final bool isVisible;
//
//   const AnimatedDescription({
//     Key? key,
//     required this.isVisible,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     final descriptionHeight = mq.size.width * 0.2;
//     final descriptionWidth = mq.size.width * 0.7;
//
//     final descriptionFinishPosition = (mq.size.height / 2.0) -
//         descriptionHeight -
//         mq.viewPadding.top -
//         StyleConstraints.bottomBarHeight - 10.0;
//     final descriptionStartPosition = descriptionFinishPosition - (mq.size.height * 0.12);
//
//     return AnimatedPositioned(
//       duration: const Duration(seconds: 1),
//       bottom: isVisible ? descriptionFinishPosition : descriptionStartPosition,
//       child: AnimatedOpacity(
//         duration: const Duration(seconds: 1),
//         opacity: isVisible ? 1.0 : 0.0,
//         child: SizedBox(
//           width: descriptionWidth,
//           child: const Text(
//             'Connection physical to metaverse',
//             style: TextStyle(
//               fontSize: 24.0,
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 2,
//           ),
//         ),
//       )
//     );
//   }
// }
