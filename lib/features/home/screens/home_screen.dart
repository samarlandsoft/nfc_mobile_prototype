import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/push_next_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_text_button.dart';
import 'package:nfc_mobile_prototype/core/widgets/scaffold_wrapper.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/locator.dart';
import 'package:nfc_mobile_prototype/features/home/widgets/salt_circular_text.dart';
import 'package:nfc_mobile_prototype/features/home/widgets/salt_logo.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  static const screenIndex = 0;

  const HomeScreen({Key? key}) : super(key: key);

  void _onScanTappedHandler() {
    locator<PushNextScreen>().call(ScannerScreen.screenIndex);
  }

  void _onMarketTappedHandler() {
    locator<PushNextScreen>().call(MarketScreen.screenIndex);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenCenter = (mq.size.height - mq.viewPadding.top) * 0.5;

    final wrapperVerticalPadding = mq.viewPadding.top +
        StyleConstants.kDefaultPadding +
        ScaffoldWrapper.getLabelSize(context);
    final gestureSize = mq.size.width * 0.75;

    return BlocBuilder<MarketBloc, MarketBlocState>(
      buildWhen: (prev, current) {
        return prev.isMarketInit != current.isMarketInit;
      },
      builder: (context, state) {
        return ContentWrapper(
          widget: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: screenCenter -
                    wrapperVerticalPadding -
                    SaltLogo.getLogoSize(context) * 0.5,
                child: const SaltLogo(),
              ),
              Positioned(
                top: screenCenter -
                    wrapperVerticalPadding -
                    SaltCircularText.getTextRadius(context),
                child: const SaltCircularText(),
              ),
              Positioned(
                top: screenCenter -
                    wrapperVerticalPadding -
                    SaltCircularText.getTextRadius(context),
                child: const SaltCircularText(),
              ),
              Positioned(
                top: screenCenter - wrapperVerticalPadding - gestureSize * 0.5,
                child: SizedBox(
                  height: gestureSize,
                  width: gestureSize,
                  child: GestureDetector(
                    onTap: _onScanTappedHandler,
                  ),
                ),
              ),
              Positioned(
                bottom: StyleConstants.kDefaultPadding * 2.0,
                child: AbsorbPointer(
                  absorbing: !state.isMarketInit,
                  child: SaltTextButton(
                    label: 'VIEW COLLECTION',
                    callback: _onMarketTappedHandler,
                    isLoading: !state.isMarketInit,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
