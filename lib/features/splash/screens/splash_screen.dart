import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_scanner_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/features/splash/widgets/animated_loader.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class SplashScreen extends StatefulWidget {
  static const index = 0;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _disableDuration = 200;
  static const _logoSize = 150.0;
  late AnimationController _controller;
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.repeat();

    _futureRequestsImitation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _futureRequestsImitation() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        _isDisabled = true;
      });
      Future.delayed(const Duration(milliseconds: _disableDuration ~/ 2))
          .then((_) {
        _controller.stop();
      });
      locator<UpdateScreenIndex>().call(NfcScannerScreen.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logoPosition = (mq.size.height / 2.0) - (_logoSize / 2.0) - mq.viewPadding.top;

    return ContentWrapper(
      backgroundSrc: 'assets/icons/background_1.png',
      widget: AnimatedOpacity(
        duration: const Duration(milliseconds: _disableDuration),
        opacity: _isDisabled ? 0.0 : 1.0,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: logoPosition,
              child: AnimatedLoader(
                height: _logoSize,
                width: _logoSize,
                animation: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
