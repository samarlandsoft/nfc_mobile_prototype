import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class SweaterCounter extends StatelessWidget {
  final int sold, amount;

  const SweaterCounter({
    Key? key,
    required this.sold,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: StyleConstants.kSelectedColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: StyleConstants.kDefaultPadding * 0.4,
        horizontal: StyleConstants.kDefaultPadding * 0.8,
      ),
      child: Row(
        children: <Widget>[
          Text(
            sold.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(' / '),
          Text(amount.toString()),
        ],
      ),
    );
  }
}