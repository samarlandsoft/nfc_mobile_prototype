import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/card_tags.dart';

class ProductDescription extends StatelessWidget {
  final NFCSweater product;
  final double? width;

  const ProductDescription({
    Key? key,
    required this.product,
    this.width,
  }) : super(key: key);

  Widget _buildSmallItemDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.edition,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          product.description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDetailedItemDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: StyleConstants.kDefaultPadding * 3.0,
        horizontal: StyleConstants.kDefaultPadding * 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.title,
            style: TextStyle(
              fontSize: 30.0,
              color: product.currency == CryptoCurrency.btc
                  ? const Color(0xFFF7931A)
                  : const Color(0xFF4CC9F0),
            ),
          ),
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
            ),
          if (product.priceStep != null)
            Text(
              'Price step: ${product.priceStep.toString()}',
            ),
          if (product.sold != null)
            Text(
              'Sold: ${product.sold.toString()}',
            ),
          if (product.amount != null)
            Text(
              'Edition of: ${product.amount.toString()}',
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
          : _buildDetailedItemDescription(),
    );
  }
}
