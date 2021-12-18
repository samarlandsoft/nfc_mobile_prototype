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
        NavigationCore.getVerticalPadding(context, withTopView: false) +
        ContentWrapper.getWrapperPadding(context);
    final double viewBottomPadding =
        StyleConstants.kGetSystemNavigationBarSize(context) +
            NavigationCore.getBottomCurtainSize(context) +
            ContentWrapper.getWrapperPadding(context);

    return SafeArea(
      child: ContentWrapper(
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
                    padding: EdgeInsets.zero,
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
            SizedBox(
              height: viewBottomPadding,
            ),
          ],
        ),
      ),
    );
  }
}
