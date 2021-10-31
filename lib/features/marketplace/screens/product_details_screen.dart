import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/gradient_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_description.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/details';
  final DetailsProduct detailsProduct;

  const ProductDetailsScreen({
    Key? key,
    required this.detailsProduct,
  }) : super(key: key);

  void _onGoBackButtonHandler(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final imageSize = mq.size.width * 0.8;

    return Scaffold(
      body: ContentWrapper(
        withBottomBar: false,
        widget: Column(
          children: <Widget>[
            Expanded(
              child: ScrollableWrapper(
                widgets: <Widget>[
                  GradientWrapper(
                    height: imageSize,
                    width: imageSize,
                    gradient: detailsProduct.gradient,
                    imageSrc: detailsProduct.product.imageSrc,
                    chipSrc: detailsProduct.product.chipSrc,
                    wrapperPadding: 15.0,
                    cardPadding: 15.0,
                  ),
                  ProductDescription(
                    product: detailsProduct.product,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: NeonButton(
                label: 'Go back',
                callback: () => _onGoBackButtonHandler(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
