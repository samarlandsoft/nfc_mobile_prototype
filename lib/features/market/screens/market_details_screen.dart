import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_card_extended.dart';

class MarketDetailsScreen extends StatelessWidget {
  static const screenIndex = 4;

  const MarketDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketBloc, MarketBlocState>(
      builder: (context, state) {
        return ContentWrapper(
          widget: ScrollableWrapper(
            widgets: [
              if (state.activeSweater != null)
                SweaterCardExtended(
                  sweater: state.activeSweater!,
                ),
            ],
          ),
        );
      },
    );
  }
}
