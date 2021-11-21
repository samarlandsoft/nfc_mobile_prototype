import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/core/widgets/animated_app_icon.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/marketplace_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_scanner_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class HomeScreen extends StatefulWidget {
  static const String titleName = '';
  static const int screenIndex = 1;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _animationDuration = 1000;
  late Timer _timer;
  bool _isInit = false;
  bool _isPulsed = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _playAnimation(_animationDuration);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _playAnimation(int duration) {
    Future.delayed(Duration(milliseconds: duration)).then((_) {
      setState(() {
        _isInit = true;
      });

      _timer = Timer.periodic(Duration(milliseconds: duration), (_) {
        setState(() {
          _isPulsed = !_isPulsed;
        });
      });
    });
  }

  void _onNavigationButtonHandler(int screen) {
    locator<UpdateScreenIndex>().call(screen);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final iconPadding = mq.size.height * 0.1;
    final descriptionWidth = mq.size.width * 0.7;
    final buttonWidth = mq.size.width * 0.7;

    return BlocBuilder<AppBloc, AppBlocState>(buildWhen: (prev, current) {
      return prev.isSplashPlayed != current.isSplashPlayed;
    }, builder: (context, state) {
      return ContentWrapper(
        title: HomeScreen.titleName,
        backgroundSrc: 'assets/images/background_1.png',
        widget: Padding(
          padding: const EdgeInsets.fromLTRB(
            StyleConstants.kDefaultPadding,
            0.0,
            StyleConstants.kDefaultPadding,
            StyleConstants.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: descriptionWidth,
                child: const Text(
                  'Connection physical to metaverse',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: iconPadding * 1.5,
              ),
              AnimatedAppIcon(
                isVisible: (_isInit || state.isSplashPlayed),
                isPulsed: _isPulsed,
                withPosition: false,
                duration: _animationDuration,
              ),
              SizedBox(
                height: iconPadding,
              ),
              Expanded(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: _animationDuration),
                  opacity: (_isInit || state.isSplashPlayed) ? 1.0 : 0.0,
                  child: AbsorbPointer(
                    absorbing: !(_isInit || state.isSplashPlayed),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        NeonButton(
                          label: 'Marketplace',
                          callback: () => _onNavigationButtonHandler(
                              MarketplaceScreen.screenIndex),
                          width: buttonWidth,
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding,
                        ),
                        NeonButton(
                          label: 'Scan NFC',
                          callback: () => _onNavigationButtonHandler(
                              NFCScannerScreen.screenIndex),
                          width: buttonWidth,
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding,
                        ),
                        NeonButton(
                          label: 'About',
                          callback: () => _onNavigationButtonHandler(
                              AboutScreen.screenIndex),
                          width: buttonWidth,
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
