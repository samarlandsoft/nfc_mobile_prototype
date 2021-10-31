import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/product.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/grid_product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  final List<DetailsProduct> _demoProducts = const [
    DetailsProduct(
      product: Product(
        title: 'Season 1 Can\'t Be Stopped - Bitcoin Edition',
        edition: 'Bitcoin Edition',
        description:
            'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
        tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
        currency: CryptoCurrency.btc,
        imageSrc: 'assets/images/bitcoin_sweater.gif',
        chipSrc: 'assets/images/bitcoin_chip.gif',
        price: 6.05,
        priceStep: 0.28,
        amount: 20,
        sold: 16,
      ),
      gradient: [
        Color(0xFF083d77),
        Color(0xFFF7931A),
      ],
    ),
    DetailsProduct(
      product: Product(
        title: 'Season 1 Can\'t Be Stopped - Ethereum Edition',
        edition: 'Ethereum Edition',
        description:
        'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
        tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
        currency: CryptoCurrency.eth,
        imageSrc: 'assets/images/ethereum_sweater.gif',
        chipSrc: 'assets/images/ethereum_chip.gif',
        price: 6.05,
        priceStep: 0.28,
        amount: 20,
        sold: 16,
      ),
      gradient: [
        Color(0xFF4CC9F0),
        Color(0xFFF72585),
      ],
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: _demoProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (context, index) {
        return GridProductCard(
          detailsProduct: _demoProducts[index],
        );
      },
    );
  }
}
