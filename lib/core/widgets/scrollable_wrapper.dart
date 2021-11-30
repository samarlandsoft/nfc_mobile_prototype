import 'package:flutter/material.dart';

/// Wrap [ScrollableWrapper] into Expanded widget
class ScrollableWrapper extends StatelessWidget {
  final List<Widget> widgets;
  final Axis direction;
  final bool isReversed;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ScrollableWrapper({
    Key? key,
    required this.widgets,
    this.direction = Axis.vertical,
    this.isReversed = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: direction,
      reverse: isReversed,
      physics: const BouncingScrollPhysics(),
      child: Flex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: widgets,
      ),
    );
  }
}
