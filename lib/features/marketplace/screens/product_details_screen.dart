import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/gradient_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_description.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/details';
  final NFCSweater sweater;
  final bool fromToken;

  const ProductDetailsScreen({
    Key? key,
    required this.sweater,
    this.fromToken = false,
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
                    imageSrc: sweater.imageSrc,
                    chipSrc: sweater.chipSrc,
                    currency: sweater.currency,
                    wrapperPadding: StyleConstants.kDefaultPadding * 1.5,
                    cardPadding: StyleConstants.kDefaultPadding * 1.5,
                  ),
                  ProductDescription(
                    product: sweater,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: StyleConstants.kDefaultPadding),
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
