import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/scaffold_wrapper.dart';

/// Wrap [ScrollableWrapper] into Expanded widget
class ScrollableWrapper extends StatelessWidget {
  final List<Widget> widgets;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool withVerticalPadding;

  const ScrollableWrapper({
    Key? key,
    required this.widgets,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.withVerticalPadding = true,
  }) : super(key: key);

  List<Widget> _buildMultipleChild(BuildContext context) {
    return [
      ...widgets,
      SizedBox(
        height: ScaffoldWrapper.getBottomCurtainSize(context) +
            StyleConstants.kDefaultPadding * 2.0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: direction,
      physics: const BouncingScrollPhysics(),
      child: Flex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: withVerticalPadding ? _buildMultipleChild(context) : widgets,
      ),
    );
  }
}
