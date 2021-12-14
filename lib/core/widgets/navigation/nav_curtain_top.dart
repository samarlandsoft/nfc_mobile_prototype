import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_fade_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_position_transition.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class NavCurtainTop extends StatelessWidget {
  final Curve curve;
  final double lowerBoundValue;
  final double upperBoundValue;

  const NavCurtainTop({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
    required this.lowerBoundValue,
    required this.upperBoundValue,
  }) : super(key: key);

  Widget _buildAboutBranch(AppBlocState state, double size) {
    final double topBound = state.isTopCurtainEnabled
        ? (lowerBoundValue + StyleConstants.kDefaultPadding * 2.0)
        : -size;
    final double bottomBound = state.isTopCurtainEnabled
        ? 0.0
        : (lowerBoundValue + StyleConstants.kDefaultPadding * 2.0);

    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildAboutBranch'),
      curve: curve,
      upperBoundValue: topBound,
      lowerBoundValue: bottomBound,
      child: AnimationFadeTransition(
        curve: StyleConstants.kEaseInOutCubicCustom,
        opacity: 1.0,
        isActive: state.isTopCurtainEnabled,
        child: const AboutScreen(),
      ),
    );
  }

  Widget _buildScannerBranch(AppBlocState state, double size) {
    final double topPadding =
        (lowerBoundValue + StyleConstants.kDefaultPadding * 2.0);

    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildScannerBranch'),
      curve: curve,
      upperBoundValue: 0.0,
      height: state.isTopCurtainEnabled ? (size + lowerBoundValue) : 0.0,
      child: AnimatedSwitcher(
        duration: Duration(
            milliseconds:
                (StyleConstants.kDefaultTransitionDuration * 0.5).toInt()),
        switchOutCurve: Curves.ease,
        switchInCurve: Curves.ease,
        child: state.routes.last == ScannerScreen.screenIndex
            ? const ScannerScreen()
            : Padding(
                padding: EdgeInsets.only(top: topPadding),
                child: const AboutScreen(),
              ),
      ),
    );
  }

  Widget _buildMarketBranch(AppBlocState state, double size) {
    final double topBound = state.isTopCurtainEnabled
        ? (lowerBoundValue + StyleConstants.kDefaultPadding * 2.0)
        : -size;
    final double bottomBound = state.isTopCurtainEnabled
        ? 0.0
        : (lowerBoundValue + StyleConstants.kDefaultPadding * 2.0);

    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildAboutBranch'),
      curve: curve,
      upperBoundValue: topBound,
      lowerBoundValue: bottomBound,
      child: AnimationFadeTransition(
        curve: curve,
        opacity: 1.0,
        isActive: state.isTopCurtainEnabled,
        child: _buildMarketDetailsBranch(state, size),
      ),
    );
  }

  Widget _buildMarketDetailsBranch(AppBlocState state, double size) {
    final int previousScreen = state.routes.length != 1
        ? state.routes[state.routes.indexOf(state.routes.last) - 1]
        : state.routes.last;
    final double topPadding =
        (lowerBoundValue + StyleConstants.kDefaultPadding * 2.0);

    return AnimationFadeTransition(
      curve: curve,
      opacity: 1.0,
      isActive: state.isTopCurtainEnabled,
      child: AnimatedSwitcher(
        duration: Duration(
            milliseconds:
                (StyleConstants.kDefaultTransitionDuration * 0.5).toInt()),
        switchOutCurve: Curves.ease,
        switchInCurve: Curves.ease,
        child: state.routes.last == MarketDetailsScreen.screenIndex
            ? const MarketDetailsScreen()
            : Padding(
                padding: EdgeInsets.only(
                    top:
                        state.routes[previousScreen] == MarketScreen.screenIndex
                            ? topPadding
                            : 0.0),
                child: const AboutScreen(),
              ),
      ),
    );
  }

  Widget _buildCurrentScreen(AppBlocState state, double size) {
    if (state.routes.contains(ScannerScreen.screenIndex)) {
      return _buildScannerBranch(state, size);
    }

    if (state.routes.contains(MarketScreen.screenIndex)) {
      return _buildMarketBranch(state, size);
    }

    return _buildAboutBranch(state, size);
  }

  @override
  Widget build(BuildContext context) {
    final double contentHeight = upperBoundValue - lowerBoundValue;

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isTopCurtainEnabled != current.isTopCurtainEnabled ||
            prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        return AnimationPositionTransition(
          key: const ValueKey('_NavCurtainTop'),
          curve: curve,
          upperBoundValue: 0.0,
          lowerBoundValue:
              state.isTopCurtainEnabled ? lowerBoundValue : upperBoundValue,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              _buildCurrentScreen(state, contentHeight),
            ],
          ),
        );
      },
    );
  }
}
