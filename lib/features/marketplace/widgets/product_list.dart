import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  final List<NFCSweater> sweaters;

  const ProductList({
    Key? key,
    required this.sweaters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final listPadding = mq.size.width * 0.1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: listPadding),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: sweaters.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.8,
          mainAxisSpacing: StyleConstants.kDefaultPadding * 6.0,
          crossAxisSpacing: StyleConstants.kDefaultPadding,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            sweater: sweaters[index],
          );
        },
      ),
    );
  }
}
