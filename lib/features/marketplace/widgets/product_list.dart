import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/grid_product_card.dart';

class ProductList extends StatelessWidget {
  final List<NFCSweater> sweaters;

  const ProductList({
    Key? key,
    required this.sweaters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: sweaters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        mainAxisSpacing: StyleConstants.kDefaultPadding,
        crossAxisSpacing: StyleConstants.kDefaultPadding,
      ),
      itemBuilder: (context, index) {
        return GridProductCard(
          sweater: sweaters[index],
        );
      },
    );
  }
}
