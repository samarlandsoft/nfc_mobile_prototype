import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/usecases/pop_current_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_position_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_scale_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/buttons/salt_combined_button.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_active_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class NavCurtainBottom extends StatelessWidget {
  final Curve curve;
  final double lowerBoundValue;
  final double upperBoundValue;

  const NavCurtainBottom({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
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
        return AnimationPositionTransition(
          key: const ValueKey('_NavCurtainBottom'),
          curve: curve,
          upperBoundValue:
              state.isBottomCurtainEnabled ? upperBoundValue : lowerBoundValue,
          lowerBoundValue: 0.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
            child: _BottomNavigationButton(
              curve: curve,
              upperBoundValue: 0.0,
              lowerBoundValue: 0.0,
            ),
          ),
        );
      },
    );
  }
}

class _BottomNavigationButton extends StatefulWidget {
  final Curve curve;
  final double upperBoundValue;
  final double lowerBoundValue;

  const _BottomNavigationButton({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
    required this.upperBoundValue,
    required this.lowerBoundValue,
  }) : super(key: key);

  @override
  State<_BottomNavigationButton> createState() =>
      _BottomNavigationButtonState();
}

class _BottomNavigationButtonState extends State<_BottomNavigationButton> {
  int _prevuisScreen = 0;

  void _onPopTappedHandler({bool fromMarketDetails = false}) {
    locator<PopCurrentScreen>().call(NoParams());
    if (fromMarketDetails) {
      locator<UpdateMarketActiveSweater>().call(null);
    }
  }

  Widget _getBottomButtonText(int screen, double width,
      {bool withUpdate = true}) {
    if (withUpdate) {
      _prevuisScreen = screen;
    }

    switch (_prevuisScreen) {
      case ScannerScreen.screenIndex:
        {
          return SaltCombinedButton(
            key: const ValueKey('_getBottomButtonText_ScannerScreen'),
            label: 'STOP',
            iconSrc: 'assets/icons/close.png',
            callback: _onPopTappedHandler,
            width: width,
          );
        }

      case MarketScreen.screenIndex:
        {
          return SaltCombinedButton(
            key: const ValueKey('_getBottomButtonText_MarketScreen'),
            label: 'BACK',
            iconSrc: 'assets/icons/back.png',
            callback: _onPopTappedHandler,
            width: width,
          );
        }

      case MarketDetailsScreen.screenIndex:
        {
          return SaltCombinedButton(
            key: const ValueKey('_getBottomButtonText_MarketDetailsScreen'),
            label: 'CLOSE',
            iconSrc: 'assets/icons/close.png',
            callback: () => _onPopTappedHandler(fromMarketDetails: true),
            width: width,
          );
        }

      case AboutScreen.screenIndex:
        {
          return SaltCombinedButton(
            key: const ValueKey('_getBottomButtonText_AboutScreen'),
            label: 'CLOSE',
            iconSrc: 'assets/icons/close.png',
            callback: _onPopTappedHandler,
            width: width,
          );
        }

      default:
        {
          return SaltCombinedButton(
            key: const ValueKey('_getBottomButtonText_Default'),
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

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isBottomCurtainEnabled != current.isBottomCurtainEnabled ||
            prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        final int previousScreen = state.routes.length != 1
            ? state.routes[state.routes.indexOf(state.routes.last) - 1]
            : state.routes.last;
        final int screenToShow =
            state.routeToRemove == null ? state.routes.last : previousScreen;

        return AnimationScaleTransition(
          curve: widget.curve,
          scale: 1.0,
          isActive: state.isBottomCurtainEnabled,
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(
                  milliseconds:
                      (StyleConstants.kDefaultTransitionDuration * 0.5)
                          .toInt()),
              switchOutCurve: Curves.ease,
              switchInCurve: Curves.ease,
              child: _getBottomButtonText(
                screenToShow,
                mq.size.width * 0.6,
                withUpdate: screenToShow != HomeScreen.screenIndex,
              ),
            ),
          ),
        );
      },
    );
  }
}
