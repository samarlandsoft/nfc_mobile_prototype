import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/domain/models/product.dart';
import 'package:nfc_mobile_prototype/features/content/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  ProductList({Key? key}) : super(key: key);

  final List<DetailsProduct> _demoProducts = [
    DetailsProduct(
      product: Product(
        title: 'Season 1 Can\'t Be Stopped - Bitcoin Edition',
        edition: 'Bitcoin Edition',
        description:
            'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
        tags: ['Genesis, NFT, ERC721, NFC'],
        imageSrc: 'assets/icons/bitcoin.gif',
        price: 6.05,
        priceStep: 0.28,
        amount: 20,
        sold: 16,
      ),
      gradient: const [
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
        tags: ['Genesis, NFT, ERC721, NFC'],
        imageSrc: 'assets/icons/ethereum.gif',
        price: 6.05,
        priceStep: 0.28,
        amount: 20,
        sold: 16,
      ),
      gradient: const [
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
        return ProductCard(
          detailsProduct: _demoProducts[index],
        );
      },
    );
  }
}
