import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_combined_button.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_icon_button.dart';
import 'package:nfc_mobile_prototype/locator.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class ScaffoldWrapper extends StatelessWidget {
  final Widget widget;

  const ScaffoldWrapper({
    Key? key,
    required this.widget,
  }) : super(key: key);

  static getLabelSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.size.width * 0.2;
  }

  static getVerticalPadding(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.viewPadding.top + StyleConstants.kDefaultPadding;
  }

  static getBottomCurtainSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    return (mq.size.height - mq.viewPadding.top) * 0.12;
  }

  void _onHomeTappedHandler() {
    locator<UpdateScreenIndex>().call(HomeScreen.screenIndex);
    locator<UpdateWrapperCurtainMode>().call(
      NoParams(),
      isTopCurtainEnabled: false,
      isBottomCurtainEnabled: false,
    );
  }

  void _onAboutTappedHandler() {
    locator<UpdateScreenIndex>().call(AboutScreen.screenIndex);
    locator<UpdateWrapperCurtainMode>().call(
      NoParams(),
      isTopCurtainEnabled: true,
      isBottomCurtainEnabled: true,
    );
  }

  Widget _getBottomButtonText(int screen, double width) {
    switch (screen) {
      case AboutScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'CLOSE',
            iconSrc: 'assets/icons/close.png',
            callback: _onHomeTappedHandler,
            width: width,
          );
        }

      case ScannerScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'STOP',
            iconSrc: 'assets/icons/close.png',
            callback: _onHomeTappedHandler,
            width: width,
          );
        }

      case MarketScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'BACK',
            iconSrc: 'assets/icons/back.png',
            callback: _onHomeTappedHandler,
            width: width,
          );
        }

      case MarketDetailsScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'CLOSE',
            iconSrc: 'assets/icons/close.png',
            callback: _onHomeTappedHandler,
            width: width,
          );
        }

      default:
        {
          return SaltCombinedButton(
            label: 'BACK',
            iconSrc: 'assets/icons/back.png',
            callback: _onHomeTappedHandler,
            width: width,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final labelHeight = getLabelSize(context);
    final topPadding = getVerticalPadding(context);

    return BlocBuilder<AppBloc, AppBlocState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            if (!state.isCurtainOpacityEnabled)
              Positioned(
                top: 0.0,
                bottom: state.isTopCurtainEnabled
                    ? getBottomCurtainSize(context)
                    : mq.size.height - (topPadding + labelHeight),
                left: 0.0,
                right: 0.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
            if (!state.isCurtainOpacityEnabled)
              Positioned(
                top: topPadding,
                left: 0.0,
                right: 0.0,
                child: _SaltLabel(
                  height: labelHeight,
                  callback: _onAboutTappedHandler,
                ),
              ),
            Positioned(
              top: state.isCurtainOpacityEnabled
                  ? mq.viewPadding.top
                  : mq.viewPadding.top + getLabelSize(context),
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: widget,
            ),
            if (state.isCurtainOpacityEnabled)
              Positioned(
                top: 0.0,
                bottom: state.isTopCurtainEnabled
                    ? getBottomCurtainSize(context)
                    : mq.size.height - (topPadding + labelHeight),
                left: 0.0,
                right: 0.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
            if (state.isCurtainOpacityEnabled)
              Positioned(
                top: topPadding,
                left: 0.0,
                right: 0.0,
                child: _SaltLabel(
                  height: labelHeight,
                  callback: _onAboutTappedHandler,
                ),
              ),
            Positioned(
              top: state.isBottomCurtainEnabled
                  ? mq.size.height - (getBottomCurtainSize(context) - 2.0)
                  : mq.size.height,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            if (state.isBottomCurtainEnabled)
              Positioned(
                top: mq.size.height -
                    (getBottomCurtainSize(context) - 2.0) +
                    StyleConstants.kDefaultPadding,
                bottom: StyleConstants.kDefaultPadding,
                child: Center(
                  child: _getBottomButtonText(
                    state.currentScreenIndex,
                    mq.size.width * 0.6,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _SaltLabel extends StatelessWidget {
  final double height;
  final VoidCallback callback;

  const _SaltLabel({
    Key? key,
    required this.height,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.currentScreenIndex != current.currentScreenIndex;
      },
      builder: (context, state) {
        return SizedBox(
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              if (state.currentScreenIndex != AboutScreen.screenIndex)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: StyleConstants.kDefaultPadding +
                            (mq.size.width * 0.05)),
                    child: SaltIconButton(
                      iconSrc: 'assets/icons/info.png',
                      callback: callback,
                    ),
                  ),
                ),
              Center(
                child: Image.asset(
                  'assets/icons/logo.png',
                  height: height * 0.8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
