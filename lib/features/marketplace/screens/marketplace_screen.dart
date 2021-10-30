import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/product_list.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_scanner_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class MarketplaceScreen extends StatefulWidget {
  static const index = 2;

  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  static const _disableDuration = 200;
  bool _isDisabled = false;

  void _onGoBackButtonHandler() {
    setState(() {
      _isDisabled = true;
    });
    Future.delayed(const Duration(milliseconds: _disableDuration ~/ 2))
        .then((_) {
    });
    locator<UpdateScreenIndex>().call(NfcScannerScreen.index);
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
