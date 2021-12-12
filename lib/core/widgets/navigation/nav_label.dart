import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/push_next_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_fade_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/buttons/salt_icon_button.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class NavLabel extends StatelessWidget {
  final double height;
  final double upperBoundValue;

  const NavLabel({
    Key? key,
    required this.height,
    required this.upperBoundValue,
  }) : super(key: key);

  void _onAboutTappedHandler() {
    locator<PushNextScreen>().call(AboutScreen.screenIndex);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return Positioned(
      top: upperBoundValue,
      left: 0.0,
      right: 0.0,
      child: SizedBox(
        height: height,
        child: BlocBuilder<AppBloc, AppBlocState>(
          buildWhen: (prev, current) {
            return prev.routes.last != current.routes.last ||
                prev.routeToRemove != current.routeToRemove;
          },
          builder: (context, state) {
            final bool isButtonActive =
                state.routes.last != AboutScreen.screenIndex ||
                    state.routeToRemove == AboutScreen.screenIndex;

            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: StyleConstants.kDefaultPadding +
                          (mq.size.width * 0.05),
                    ),
                    child: AnimationFadeTransition(
                      opacity: 1.0,
                      isActive: isButtonActive,
                      child: AbsorbPointer(
                        absorbing: !isButtonActive,
                        child: SaltIconButton(
                          iconSrc: 'assets/icons/info.png',
                          callback: _onAboutTappedHandler,
                          size: isLargeScreen ? 30.0 : 20.0,
                        ),
                      ),
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