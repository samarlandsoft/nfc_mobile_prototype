import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater_props.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/product_details_screen.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/gradient_wrapper.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_description.dart';

class ProductCard extends StatelessWidget {
  final NFCSweater sweater;

  const ProductCard({
    Key? key,
    required this.sweater,
  }) : super(key: key);

  void _onProductTapHandler(BuildContext context, NFCSweater sweater) {
    Navigator.of(context).pushNamed(
      ProductDetailsScreen.routeName,
      arguments: NFCSweaterProps(
        sweater: sweater,
        fromToken: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: const BorderRadius.all(
                Radius.circular(StyleConstants.kDefaultPadding)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => _onProductTapHandler(context, sweater),
                child: GradientWrapper(
                  height: constraints.maxWidth,
                  width: constraints.maxWidth,
                  imageSrc: sweater.imageSrc,
                  currency: sweater.currency,
                  wrapperPadding: StyleConstants.kDefaultPadding,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(StyleConstants.kDefaultPadding * 0.5),
                child: ProductDescription(
                  width: constraints.maxWidth,
                  product: sweater,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
