import 'dart:ui';

import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String? imageSrc;
  final VoidCallback callback;
  final bool isRounded, isTapped;
  final double? width, radius;
  final Color activeColor, disabledColor;

  static const roundedSize = 60.0;

  static double getButtonHeight(BuildContext context) {
    final mq = MediaQuery.of(context);
    final textSize = TextPainter(
      text: const TextSpan(
        text: 'none',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);
    return textSize.height + 12.0 * 2;
  }

  const NeonButton({
    Key? key,
    this.label,
    this.icon,
    this.imageSrc,
    required this.callback,
    this.isRounded = false,
    this.isTapped = false,
    this.width,
    this.radius,
    this.activeColor = Colors.orange,
    this.disabledColor = Colors.grey,
  }) : super(key: key);

  Widget _buildOutlineButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: activeColor,
          width: 4.0,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      onPressed: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        child: Text(
          label != null ? label! : '',
          style: TextStyle(
            fontSize: 22.0,
            color: activeColor,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildRoundedButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isTapped
            ? activeColor.withOpacity(0.3)
            : disabledColor.withOpacity(0.3),
        side: BorderSide(
          color: isTapped ? activeColor : disabledColor,
          width: 4.0,
        ),
        fixedSize: Size(radius ?? roundedSize, radius ?? roundedSize),
        shape: const CircleBorder(),
      ),
      onPressed: callback,
      child: icon != null
          ? Icon(
              icon!,
              size: roundedSize * 0.5,
              color: isTapped ? activeColor : disabledColor,
            )
          : imageSrc != null
              ? Image.asset(imageSrc!)
              : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isRounded
        ? _buildRoundedButton()
        : width != null
            ? SizedBox(
                width: width,
                child: _buildOutlineButton(),
              )
            : _buildOutlineButton();
  }
}
