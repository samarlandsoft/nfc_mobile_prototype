import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_list.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';

class MarketplaceScreen extends StatefulWidget {
  static const String titleName = 'Marketplace';
  static const int screenIndex = 2;

  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  @override
  Widget build(BuildContext context) {
    return ContentWrapper(
      title: MarketplaceScreen.titleName,
      backgroundSrc: 'assets/images/background_2.png',
      withNavigation: true,
      widget: BlocBuilder<MarketBloc, MarketBlocState>(
        buildWhen: (prev, current) {
          return prev.sweaters != current.sweaters;
        },
        builder: (context, state) {
          return ProductList(sweaters: state.sweaters);
        },
      ),
    );
  }
}
