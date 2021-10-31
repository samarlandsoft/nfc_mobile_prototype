import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/product_details_screen.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/gradient_wrapper.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_description.dart';

class GridProductCard extends StatelessWidget {
  final DetailsProduct detailsProduct;

  const GridProductCard({
    Key? key,
    required this.detailsProduct,
  }) : super(key: key);

  void _onProductTapHandler(BuildContext context, DetailsProduct detailsProduct) {
    Navigator.of(context).pushNamed(
      ProductDetailsScreen.routeName,
      arguments: detailsProduct,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => _onProductTapHandler(context, detailsProduct),
                child: GradientWrapper(
                  height: constraints.maxWidth,
                  width: constraints.maxWidth,
                  gradient: detailsProduct.gradient,
                  imageSrc: detailsProduct.product.imageSrc,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProductDescription(
                  width: constraints.maxWidth,
                  product: detailsProduct.product,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
