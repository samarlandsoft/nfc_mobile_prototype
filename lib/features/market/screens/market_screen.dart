import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_core.dart';
import 'package:nfc_mobile_prototype/core/widgets/wrappers/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/wrappers/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_card.dart';

class MarketScreen extends StatelessWidget {
  static const screenIndex = 2;

  const MarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double viewTopPadding = NavigationCore.getLabelSize(context) +
        NavigationCore.getVerticalPadding(context) +
        (Platform.isAndroid ? 0.0 : StyleConstants.kDefaultPadding);

    return ContentWrapper(
      withViewTopPadding: true,
      widget: ScrollableWrapper(
        widgets: <Widget>[
          SizedBox(
            height: viewTopPadding,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: StyleConstants.kDefaultPadding,
            ),
            child: BlocBuilder<MarketBloc, MarketBlocState>(
              builder: (context, state) {
                if (!state.isMarketInit) {
                  return Container();
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.sweaters.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: StyleConstants.kGetScreenRatio(context)
                          ? StyleConstants.kDefaultPadding * 3.0
                          : StyleConstants.kDefaultPadding * 1.5,
                    );
                  },
                  itemBuilder: (context, index) {
                    return SweaterCard(sweater: state.sweaters[index]);
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: StyleConstants.kDefaultPadding * 5.0,
          ),
        ],
      ),
    );
  }
}
