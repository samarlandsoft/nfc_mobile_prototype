import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/domain/services/logger.dart';
import 'package:nfc_mobile_prototype/domain/usecases/update_index.dart';
import 'package:nfc_mobile_prototype/features/loader/widgets/animated_loader.dart';
import 'package:nfc_mobile_prototype/features/shared/content_wrapper.dart';
import 'package:nfc_mobile_prototype/features/token/screens/token_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class LoaderScreen extends StatefulWidget {
  static const index = 0;

  const LoaderScreen({Key? key}) : super(key: key);

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>
    with SingleTickerProviderStateMixin {
  static const _disableDuration = 200;
  static const _logoSize = 150.0;
  late AnimationController _controller;
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();
    logDebug('LoaderScreen: INIT');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.repeat();

    _futureRequestsImitation();
  }

  @override
  void dispose() {
    logDebug('LoaderScreen: DISPOSE');
    _controller.dispose();
    super.dispose();
  }

  void _futureRequestsImitation() {
    Future.delayed(const Duration(seconds: 4)).then((_) {
      setState(() {
        _isDisabled = true;
      });
      Future.delayed(const Duration(milliseconds: _disableDuration ~/ 2))
          .then((_) {
        logDebug('LoaderScreen: STOP');
        _controller.stop();
      });
      locator<UpdateIndex>().call(TokenScreen.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logoPosition = (mq.size.height / 2.0) - (_logoSize / 2.0) - mq.viewPadding.top;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/background_1.png'),
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
                child: AnimatedLoader(
                  height: _logoSize,
                  width: _logoSize,
                  animation: _controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
