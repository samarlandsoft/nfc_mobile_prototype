import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_fade_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_position_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_curtain_bottom.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_label.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_nfc_icon.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_curtain_top.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class NavigationCore extends StatelessWidget {
  const NavigationCore({Key? key}) : super(key: key);

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

  static double getContentSize(BuildContext context,
      {bool withBottomPadding = false}) {
    final mq = MediaQuery.of(context);
    return mq.size.height -
        (getVerticalPadding(context) +
            getLabelSize(context) +
            (withBottomPadding ? getBottomCurtainSize(context) + 2.0 : 0.0));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final labelHeight = NavigationCore.getLabelSize(context);
    final topPadding = NavigationCore.getVerticalPadding(context);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const _NavAnimatedBackground(),
        const _NavHomeScreen(),
        const _NavMarketScreen(),
        NavCurtainTop(
          lowerBoundValue: NavigationCore.getBottomCurtainSize(context),
          upperBoundValue: mq.size.height - (topPadding + labelHeight),
        ),
        NavLabel(
          height: labelHeight,
          upperBoundValue: topPadding,
        ),
        const NavNFCIcon(),
        NavCurtainBottom(
          upperBoundValue: mq.size.height -
              (NavigationCore.getBottomCurtainSize(context) - 2.0),
          lowerBoundValue: mq.size.height,
        ),
      ],
    );
  }
}

class _NavAnimatedBackground extends StatefulWidget {
  const _NavAnimatedBackground({Key? key}) : super(key: key);

  @override
  _NavAnimatedBackgroundState createState() => _NavAnimatedBackgroundState();
}

class _NavAnimatedBackgroundState extends State<_NavAnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Positioned(
      top: -(mq.size.height * 0.1),
      bottom: -(mq.size.height * 0.1),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.rotate(
            angle: _controller.value * math.pi * 0.3,
            child: AnimatedScale(
              duration: const Duration(seconds: 10),
              scale: 1.0 + (_controller.value * 0.5),
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      )
    );
  }
}

class _NavHomeScreen extends StatelessWidget {
  final Curve curve;

  const _NavHomeScreen({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        final double contentHeight =
            state.routes.last == HomeScreen.screenIndex ||
                    state.routes.last == MarketScreen.screenIndex ||
                    state.routeToRemove != null
                ? NavigationCore.getContentSize(context)
                : 0.0;

        return AnimationPositionTransition(
          key: const ValueKey('_NavHomeScreen'),
          curve: curve,
          lowerBoundValue: 0.0,
          height: contentHeight,
          child: AnimationFadeTransition(
            curve: StyleConstants.kEaseInOutCubicCustom,
            opacity: 1.0,
            isActive: state.routes.last == HomeScreen.screenIndex ||
                state.routeToRemove == ScannerScreen.screenIndex,
            child: const HomeScreen(),
          ),
        );
      },
    );
  }
}

class _NavMarketScreen extends StatelessWidget {
  final Curve curve;

  const _NavMarketScreen({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        final double upperBound =
            state.routes.last == MarketScreen.screenIndex ||
                    state.routes.last == MarketDetailsScreen.screenIndex ||
                    state.routes.last == AboutScreen.screenIndex ||
                    state.routeToRemove == MarketDetailsScreen.screenIndex
                ? 0.0
                : mq.size.height;
        final double lowerBound =
            state.routes.last == MarketScreen.screenIndex ||
                    state.routes.last == MarketDetailsScreen.screenIndex ||
                    state.routes.last == AboutScreen.screenIndex ||
                    state.routeToRemove == MarketDetailsScreen.screenIndex
                ? -(StyleConstants.kDefaultPadding * 5.0)
                : -mq.size.height;

        return AnimationPositionTransition(
          key: const ValueKey('_NavMarketScreen'),
          curve: curve,
          upperBoundValue: upperBound,
          lowerBoundValue: lowerBound,
          child: AnimationFadeTransition(
            curve: Curves.easeInOutCubic,
            opacity: 1.0,
            isActive: state.routes.last == MarketScreen.screenIndex ||
                state.routeToRemove == MarketDetailsScreen.screenIndex,
            child: const MarketScreen(),
          ),
        );
      },
    );
  }
}
