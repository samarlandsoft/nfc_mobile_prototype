import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/card_tags.dart';

class ProductDescription extends StatelessWidget {
  final NFCSweater product;
  final double? width;
  final bool fromToken;

  const ProductDescription({
    Key? key,
    required this.product,
    this.width,
    this.fromToken = false,
  }) : super(key: key);

  Widget _buildSmallItemDescription() {
    return Text(
      product.title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDetailedItemDescription(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: StyleConstants.kDefaultPadding * 2.0,
        horizontal: StyleConstants.kDefaultPadding * 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: mq.size.width,
            child: Text(
              product.title,
              style: TextStyle(
                fontSize: 30.0,
                color: product.currency == CryptoCurrency.btc
                    ? const Color(0xFFF7931A)
                    : const Color(0xFF4CC9F0),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: StyleConstants.kDefaultPadding,
          ),
          if (product.sold != null && product.amount != null)
            SizedBox(
              width: mq.size.width,
              child: Text(
                fromToken
                    ? 'Your number - ${product.sold!}'
                    : '${(product.sold! + 1).toString()}/${product.amount.toString()}',
                style: TextStyle(
                  fontSize: 24.0,
                  color: product.currency == CryptoCurrency.btc
                      ? const Color(0xFFF7931A)
                      : const Color(0xFF4CC9F0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (product.sold != null && product.amount != null)
            const SizedBox(
              height: StyleConstants.kDefaultPadding,
            ),
          CardTags(tags: product.tags),
          const SizedBox(
            height: StyleConstants.kDefaultPadding,
          ),
          if (product.price != null)
            Text(
              'Current price: ${product.price.toString()}',
              style: const TextStyle(
                color: StyleConstants.kSelectedTextColor,
              ),
            ),
          if (product.priceStep != null)
            Text(
              'Price step: ${product.priceStep.toString()}',
            ),
          const SizedBox(
            height: StyleConstants.kDefaultPadding,
          ),
          const Text(
            'https://www.saltandsatoshi.com/marketplace',
            style: TextStyle(
              fontSize: 18.0,
              color: StyleConstants.kHyperlinkTextColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 22.0,
        fontFamily: 'Montserrat',
      ),
      child: width != null
          ? _buildSmallItemDescription()
          : _buildDetailedItemDescription(context),
    );
  }
}
