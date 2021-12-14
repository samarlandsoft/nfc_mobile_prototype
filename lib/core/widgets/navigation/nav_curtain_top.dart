import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_fade_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_position_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_core.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class NavCurtainTop extends StatefulWidget {
  final Curve curve;
  final double lowerBoundValue;
  final double upperBoundValue;

  const NavCurtainTop({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
    required this.lowerBoundValue,
    required this.upperBoundValue,
  }) : super(key: key);

  @override
  State<NavCurtainTop> createState() => _NavCurtainTopState();
}

class _NavCurtainTopState extends State<NavCurtainTop> {
  Widget _buildAboutBranch(AppBlocState state, double size) {
    final double topBound = state.isTopCurtainEnabled
        ? (widget.lowerBoundValue +
            NavigationCore.getCurtainOverflowSize(context))
        : -size;
    final double bottomBound = state.isTopCurtainEnabled
        ? 0.0
        : (widget.lowerBoundValue +
            NavigationCore.getCurtainOverflowSize(context));

    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildAboutBranch'),
      curve: widget.curve,
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
    Widget _switchCurrentScreen(int screen) {
      final double topPadding = (widget.lowerBoundValue +
          NavigationCore.getCurtainOverflowSize(context));

      if (screen == ScannerScreen.screenIndex) {
        return const ScannerScreen();
      }

      if (screen == MarketDetailsScreen.screenIndex) {
        return Padding(
          key: const ValueKey('_buildScannerBranch_MarketDetailsScreen'),
          padding: EdgeInsets.only(top: topPadding),
          child: const MarketDetailsScreen(),
        );
      }

      return Padding(
        key: const ValueKey('_buildScannerBranch_AboutScreen'),
        padding: EdgeInsets.only(top: topPadding),
        child: const AboutScreen(),
      );
    }

    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildScannerBranch'),
      curve: widget.curve,
      upperBoundValue: 0.0,
      height: state.isTopCurtainEnabled ? (size + widget.lowerBoundValue) : 0.0,
      child: AnimatedSwitcher(
        duration: Duration(
            milliseconds:
                (StyleConstants.kDefaultTransitionDuration * 0.5).toInt()),
        switchOutCurve: Curves.ease,
        switchInCurve: Curves.ease,
        child: _switchCurrentScreen(state.routes.last),
      ),
    );
  }

  Widget _buildMarketBranch(AppBlocState state, double size) {
    final double topBound = state.isTopCurtainEnabled
        ? (widget.lowerBoundValue +
            NavigationCore.getCurtainOverflowSize(context))
        : -size;
    final double bottomBound = state.isTopCurtainEnabled
        ? 0.0
        : (widget.lowerBoundValue +
            NavigationCore.getCurtainOverflowSize(context));

    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildAboutBranch'),
      curve: widget.curve,
      upperBoundValue: topBound,
      lowerBoundValue: bottomBound,
      child: AnimationFadeTransition(
        curve: widget.curve,
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
        (widget.lowerBoundValue + StyleConstants.kDefaultPadding * 2.0);

    return AnimationFadeTransition(
      curve: widget.curve,
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
    final mq = MediaQuery.of(context);
    final double contentHeight =
        widget.upperBoundValue - widget.lowerBoundValue + mq.viewPadding.top;

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isTopCurtainEnabled != current.isTopCurtainEnabled ||
            prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        return AnimationPositionTransition(
          key: const ValueKey('_NavCurtainTop'),
          curve: widget.curve,
          upperBoundValue: 0.0,
          lowerBoundValue: state.isTopCurtainEnabled
              ? widget.lowerBoundValue
              : widget.upperBoundValue,
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
