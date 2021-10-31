import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_list.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';

class MarketplaceScreen extends StatefulWidget {
  static const index = 0;

  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  @override
  Widget build(BuildContext context) {
    return ContentWrapper(
      backgroundSrc: 'assets/images/background_1.png',
      widget: Stack(
        alignment: Alignment.center,
        children: const <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            bottom: 90.0,
            child: ProductList(),
          ),
        ],
      ),
    );
  }
}
