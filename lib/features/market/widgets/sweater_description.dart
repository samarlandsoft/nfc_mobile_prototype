import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class SweaterDescription extends StatelessWidget {
  final String description;
  final double? price;
  final double size;

  const SweaterDescription({
    Key? key,
    required this.description,
    this.price,
    required this.size,
  }) : super(key: key);

  static double getDescriptionSize(
      BuildContext context, String description, double? price) {
    final mq = MediaQuery.of(context);
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    final descriptionSize = TextPainter(
      text: TextSpan(
        text: description,
        style: const TextStyle(
          fontSize: 12.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    final priceSize = TextPainter(
      text: TextSpan(
        text: 'Ξ ${price.toString()}',
        style: TextStyle(
          fontSize: isLargeScreen ? 30.0 : 26.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return descriptionSize.height > priceSize.height
        ? descriptionSize.height
        : priceSize.height;
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: StyleConstants.kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: size * 0.55,
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
          if (price != null)
            Text(
              'Ξ ${price.toString()}',
              style: TextStyle(
                fontSize: isLargeScreen ? 30.0 : 26.0,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
