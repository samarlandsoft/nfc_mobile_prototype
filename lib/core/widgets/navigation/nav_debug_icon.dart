import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_fade_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_core.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_dialogs.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_bloc.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_state.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/nfc_response_data.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/debug_dialog.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class NavDebugIcon extends StatelessWidget {
  final Curve curve;

  const NavDebugIcon({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
  }) : super(key: key);

  void _onDebugTapHandler(BuildContext context) {
    saltShowBottomSheet(
      context,
      BlocBuilder<DebugBloc, DebugBlocState>(
        buildWhen: (prev, current) => false,
        builder: (context, state) {
          return DebugDialog(
            debugState: state,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.03;

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        if (state.routes.last != ScannerScreen.screenIndex) {
          return Container();
        }

        return Positioned(
          bottom: NavigationCore.getBottomCurtainSize(context) +
              (StyleConstants.kDefaultPadding * 2.0),
          left: StyleConstants.kDefaultPadding + horizontalPadding,
          child: AnimationFadeTransition(
            curve: curve,
            opacity: 1.0,
            isActive: state.routeToRemove != ScannerScreen.screenIndex,
            child: GestureDetector(
              onTap: () => _onDebugTapHandler(context),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset(
                      'assets/icons/debug.png',
                      fit: BoxFit.fill,
                      color: StyleConstants.kHyperLinkColor,
                    ),
                  ),
                  const SizedBox(
                    height: StyleConstants.kDefaultPadding * 0.4,
                  ),
                  Text(
                    'DEBUG',
                    style: StyleConstants.kGetBoldTextStyle(context).copyWith(
                      fontSize: 12.0,
                      color: StyleConstants.kHyperLinkColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
