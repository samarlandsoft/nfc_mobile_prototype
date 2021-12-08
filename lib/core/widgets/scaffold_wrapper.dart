import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/usecases/pop_current_screen.dart';
import 'package:nfc_mobile_prototype/core/usecases/push_next_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_combined_button.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_icon_button.dart';
import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_active_sweater.dart';
import 'package:nfc_mobile_prototype/locator.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({Key? key}) : super(key: key);

  static const Cubic _easeInOutBackCustom = Cubic(0.68, -0.4, 0.265, 1.4);
  static const Duration _animationDuration = Duration(milliseconds: 1200);

  static double getLabelSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    return StyleConstants.kGetScreenRatio(context)
        ? mq.size.width * 0.2
        : mq.size.width * 0.14;
  }

  static double getVerticalPadding(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);
    return mq.viewPadding.top +
        (isLargeScreen
            ? StyleConstants.kDefaultPadding
            : StyleConstants.kDefaultPadding * 0.25);
  }

  static double getBottomCurtainSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    return (mq.size.height - mq.viewPadding.top) * 0.12;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final labelHeight = ScaffoldWrapper.getLabelSize(context);
    final topPadding = ScaffoldWrapper.getVerticalPadding(context);

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
            _TopCurtain(
              duration: _animationDuration,
              curve: _easeInOutBackCustom,
              lowerBoundValue: ScaffoldWrapper.getBottomCurtainSize(context),
              upperBoundValue: mq.size.height - (topPadding + labelHeight),
            ),
            _SaltLabel(
              height: labelHeight,
              topBoundValue: topPadding,
            ),
            _SaltContent(
              topBoundValue:
                  mq.viewPadding.top + ScaffoldWrapper.getLabelSize(context),
              bottomBoundValue:
                  ScaffoldWrapper.getBottomCurtainSize(context) + 2.0,
            ),
            _BottomCurtain(
              duration: _animationDuration,
              curve: Curves.easeInOutBack,
              upperBoundValue: mq.size.height -
                  (ScaffoldWrapper.getBottomCurtainSize(context) - 2.0),
              lowerBoundValue: mq.size.height,
            ),
            if (state.isBottomCurtainEnabled)
              _BottomNavigationButton(
                duration: _animationDuration,
                curve: Curves.easeInOutBack,
                topBoundValue: mq.size.height -
                    (ScaffoldWrapper.getBottomCurtainSize(context) - 2.0) +
                    StyleConstants.kDefaultPadding,
                bottomBoundValue: StyleConstants.kDefaultPadding,
              ),
          ],
        );
      },
    );
  }
}

class _SaltLabel extends StatelessWidget {
  final double height;
  final double topBoundValue;

  const _SaltLabel({
    Key? key,
    required this.height,
    required this.topBoundValue,
  }) : super(key: key);

  void _onAboutTappedHandler() {
    locator<PushNextScreen>().call(AboutScreen.screenIndex);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return Positioned(
      top: topBoundValue,
      left: 0.0,
      right: 0.0,
      child: SizedBox(
        height: height,
        child: BlocBuilder<AppBloc, AppBlocState>(
          buildWhen: (prev, current) {
            return prev.routes.last != current.routes.last;
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                if (state.routes.last != AboutScreen.screenIndex)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: StyleConstants.kDefaultPadding +
                            (mq.size.width * 0.05),
                      ),
                      child: SaltIconButton(
                        iconSrc: 'assets/icons/info.png',
                        callback: _onAboutTappedHandler,
                        size: isLargeScreen ? 30.0 : 20.0,
                      ),
                    ),
                  ),
                Center(
                  child: Image.asset(
                    'assets/icons/logo.png',
                    height: isLargeScreen ? height * 0.8 : height * 0.9,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SaltContent extends StatelessWidget {
  final double topBoundValue;
  final double bottomBoundValue;

  const _SaltContent({
    Key? key,
    required this.topBoundValue,
    required this.bottomBoundValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.routes.last != current.routes.last;
      },
      builder: (context, state) {
        return Positioned(
          top: topBoundValue,
          bottom: (state.routes.last == AboutScreen.screenIndex ||
                  state.routes.last == MarketDetailsScreen.screenIndex)
              ? bottomBoundValue
              : 0.0,
          left: 0.0,
          right: 0.0,
          child: Stack(
            children: [
              if (state.routes.last == HomeScreen.screenIndex)
                const HomeScreen(),
              if (state.routes.last == ScannerScreen.screenIndex)
                const ScannerScreen(),
              if (state.routes.last == MarketScreen.screenIndex)
                const MarketScreen(),
              if (state.routes.last == MarketDetailsScreen.screenIndex)
                const MarketDetailsScreen(),
              if (state.routes.last == AboutScreen.screenIndex)
                const AboutScreen(),
            ],
          ),
        );
      },
    );
  }
}

class _TopCurtain extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final double lowerBoundValue;
  final double upperBoundValue;

  const _TopCurtain({
    Key? key,
    required this.duration,
    required this.curve,
    required this.lowerBoundValue,
    required this.upperBoundValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isTopCurtainEnabled != current.isTopCurtainEnabled;
      },
      builder: (context, state) {
        return AnimatedPositioned(
          key: const ValueKey('_TopCurtain'),
          duration: duration,
          curve: curve,
          top: 0.0,
          bottom: state.isTopCurtainEnabled ? lowerBoundValue : upperBoundValue,
          left: 0.0,
          right: 0.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        );
      },
    );
  }
}

class _BottomCurtain extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final double lowerBoundValue;
  final double upperBoundValue;

  const _BottomCurtain({
    Key? key,
    required this.duration,
    required this.curve,
    required this.upperBoundValue,
    required this.lowerBoundValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isBottomCurtainEnabled != current.isBottomCurtainEnabled;
      },
      builder: (context, state) {
        return AnimatedPositioned(
          key: const ValueKey('_BottomCurtain'),
          duration: duration,
          curve: curve,
          top: state.isBottomCurtainEnabled ? upperBoundValue : lowerBoundValue,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        );
      },
    );
  }
}

class _BottomNavigationButton extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final double topBoundValue;
  final double bottomBoundValue;

  const _BottomNavigationButton({
    Key? key,
    required this.duration,
    required this.curve,
    required this.topBoundValue,
    required this.bottomBoundValue,
  }) : super(key: key);

  void _onPopTappedHandler({bool fromMarketDetails = false}) {
    locator<PopCurrentScreen>().call(NoParams());
    if (fromMarketDetails) {
      locator<UpdateMarketActiveSweater>().call(null);
    }
  }

  Widget _getBottomButtonText(int screen, double width) {
    switch (screen) {
      case ScannerScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'STOP',
            iconSrc: 'assets/icons/close.png',
            callback: _onPopTappedHandler,
            width: width,
          );
        }

      case MarketScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'BACK',
            iconSrc: 'assets/icons/back.png',
            callback: _onPopTappedHandler,
            width: width,
          );
        }

      case MarketDetailsScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'CLOSE',
            iconSrc: 'assets/icons/close.png',
            callback: () => _onPopTappedHandler(fromMarketDetails: true),
            width: width,
          );
        }

      case AboutScreen.screenIndex:
        {
          return SaltCombinedButton(
            label: 'CLOSE',
            iconSrc: 'assets/icons/close.png',
            callback: _onPopTappedHandler,
            width: width,
          );
        }

      default:
        {
          return SaltCombinedButton(
            label: 'BACK',
            iconSrc: 'assets/icons/back.png',
            callback: _onPopTappedHandler,
            width: width,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return AnimatedPositioned(
      key: const ValueKey('_BottomNavigationButton'),
      duration: duration,
      curve: curve,
      top: topBoundValue,
      bottom: bottomBoundValue,
      child: BlocBuilder<AppBloc, AppBlocState>(
        buildWhen: (prev, current) {
          return prev.routes.last != current.routes.last;
        },
        builder: (context, state) {
          return Center(
            child: _getBottomButtonText(
              state.routes.last,
              mq.size.width * 0.6,
            ),
          );
        },
      ),
    );
  }
}
