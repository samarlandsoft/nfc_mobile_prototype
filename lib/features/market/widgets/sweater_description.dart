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

  @override
  Widget build(BuildContext context) {
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
              'Ξ $price',
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
