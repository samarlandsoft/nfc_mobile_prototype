import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/gradient_image.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';

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
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: ContentWrapper(
              widget: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          GradientImage(
                            height: imageSize,
                            width: imageSize,
                            gradient: detailsProduct.gradient,
                            imageSrc: detailsProduct.product.imageSrc,
                            wrapperPadding: 15.0,
                            cardPadding: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 30.0,
                              horizontal: 15.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    detailsProduct.product.title,
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Current price: ${detailsProduct.product.price.toString()}',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                                Text(
                                  'Price step: ${detailsProduct.product.priceStep.toString()}',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                                Text(
                                  'Sold: ${detailsProduct.product.sold.toString()}',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                                Text(
                                  'Edition of: ${detailsProduct.product.amount.toString()}',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: NeonButton(
                              label: 'Go back',
                              callback: () => _onGoBackButtonHandler(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
