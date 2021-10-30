import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/product_details_screen.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/cart_button.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/gradient_image.dart';

class ProductCard extends StatelessWidget {
  final DetailsProduct detailsProduct;

  const ProductCard({
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
                child: GradientImage(
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
                  edition: detailsProduct.product.edition,
                  description: detailsProduct.product.description,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductDescription extends StatelessWidget {
  final double width;
  final String edition, description;

  const ProductDescription({
    Key? key,
    required this.width,
    required this.edition,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonWidth = 25.0;
    final descriptionWidth = width - buttonWidth - 10.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: descriptionWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                edition,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        CartButton(
          size: buttonWidth,
          callback: () {},
        ),
      ],
    );
  }
}
