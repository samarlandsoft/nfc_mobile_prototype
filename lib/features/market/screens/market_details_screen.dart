import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_animated_loader.dart';
import 'package:nfc_mobile_prototype/core/widgets/scaffold_wrapper.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_card_extended.dart';

class MarketDetailsScreen extends StatelessWidget {
  static const screenIndex = 4;

  const MarketDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenCenter = (mq.size.height - mq.viewPadding.top) * 0.5;
    final wrapperVerticalPadding = mq.viewPadding.top +
        StyleConstants.kDefaultPadding +
        ScaffoldWrapper.getLabelSize(context);
    final loaderSize = mq.size.width * 0.5;

    return BlocBuilder<MarketBloc, MarketBlocState>(
      builder: (context, state) {
        return ContentWrapper(
          widget: state.activeSweater != null
              ? SweaterCardExtended(
                  sweater: state.activeSweater!,
                )
              : Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: screenCenter -
                          wrapperVerticalPadding -
                          loaderSize * 0.5,
                      child: SaltAnimatedLoader(size: loaderSize),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
