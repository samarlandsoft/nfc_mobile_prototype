import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/domain/services/logger.dart';
import 'package:nfc_mobile_prototype/domain/usecases/update_index.dart';
import 'package:nfc_mobile_prototype/features/content/widgets/product_list.dart';
import 'package:nfc_mobile_prototype/features/shared/content_wrapper.dart';
import 'package:nfc_mobile_prototype/features/shared/neon_button.dart';
import 'package:nfc_mobile_prototype/features/token/screens/token_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class ContentScreen extends StatefulWidget {
  static const index = 2;

  const ContentScreen({Key? key}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  static const _disableDuration = 200;
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();
    logDebug('ContentScreen: INIT');
  }

  @override
  void dispose() {
    logDebug('ContentScreen: DISPOSE');
    super.dispose();
  }

  void _onGoBackButtonHandler() {
    setState(() {
      _isDisabled = true;
    });
    Future.delayed(const Duration(milliseconds: _disableDuration ~/ 2))
        .then((_) {
      logDebug('ContentScreen: STOP');
    });
    locator<UpdateIndex>().call(TokenScreen.index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/background_3.png'),
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
                top: 0.0,
                left: 0.0,
                right: 0.0,
                bottom: 90.0,
                child: ProductList(),
              ),
              Positioned(
                bottom: 20.0,
                child: NeonButton(
                  label: 'Back',
                  callback: _onGoBackButtonHandler,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
