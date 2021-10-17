import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/domain/services/logger.dart';
import 'package:nfc_mobile_prototype/domain/usecases/update_index.dart';
import 'package:nfc_mobile_prototype/features/content/screens/content_screen.dart';
import 'package:nfc_mobile_prototype/features/shared/content_wrapper.dart';
import 'package:nfc_mobile_prototype/features/shared/neon_button.dart';
import 'package:nfc_mobile_prototype/features/token/widgets/animated_pulse.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class TokenScreen extends StatefulWidget {
  static const index = 1;

  const TokenScreen({Key? key}) : super(key: key);

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen>
    with SingleTickerProviderStateMixin {
  static const _disableDuration = 200;
  static const _logoSize = 150.0;
  static const _iconSize = 45.0;
  late AnimationController _controller;
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();
    logDebug('TokenScreen: INIT');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    logDebug('TokenScreen: DISPOSE');
    _controller.dispose();
    super.dispose();
  }

  void _onGoNextButtonHandler() {
    setState(() {
      _isDisabled = true;
    });
    Future.delayed(const Duration(milliseconds: _disableDuration ~/ 2))
        .then((_) {
      logDebug('TokenScreen: STOP');
      _controller.stop();
    });
    locator<UpdateIndex>().call(ContentScreen.index);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logoPosition =
        (mq.size.height / 2.0) - (_logoSize / 2.0) - mq.viewPadding.top;
    final iconPosition = logoPosition + (_logoSize / 2.0) - (_iconSize / 2.0);
    final textPosition = logoPosition - (_logoSize / 2.0) - 10.0;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/background_2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: ContentWrapper(
        widget: AnimatedOpacity(
          duration: const Duration(milliseconds: _disableDuration),
          opacity: _isDisabled ? 0.0 : 1.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: logoPosition,
                child: AnimatedPulse(
                  height: _logoSize,
                  width: _logoSize,
                  animation: _controller,
                ),
              ),
              Positioned(
                bottom: iconPosition,
                child: SizedBox(
                  height: _iconSize,
                  width: _iconSize,
                  child: Image.asset('assets/icons/icon.png'),
                ),
              ),
              Positioned(
                bottom: textPosition,
                child: const Text(
                  'Scan NFC tag',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                child: NeonButton(
                  label: 'Next',
                  callback: _onGoNextButtonHandler,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
