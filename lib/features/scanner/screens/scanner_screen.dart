import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/usecases/push_next_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scaffold_wrapper.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/get_blockchain_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/scanner/widgets/nfc_response_banner.dart';
import 'package:nfc_mobile_prototype/locator.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/jwt_payload.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/usecases/read_nfc_chip.dart';
import 'package:nfc_mobile_prototype/features/scanner/widgets/salt_pulse_animation.dart';

class ScannerScreen extends StatefulWidget {
  static const screenIndex = 1;

  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _isInit = false;
  bool _isNFCAvailable = false;
  bool _isScannerBannerActive = false;
  bool _isNFCError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<NFCService>().checkNFCAvailable().then((isAvailable) {
        setState(() {
          _isInit = true;
          _isNFCAvailable = isAvailable;
        });

        if (isAvailable) {
          _listenNFC();
        }
      });
    }
  }

  @override
  void dispose() {
    locator<NFCService>().cancelScanning();
    super.dispose();
  }

  Future<void> _listenNFC() async {
    final tokenData = await locator<ReadNFCChip>().call(NoParams());

    if (tokenData.error != null) {
      _showOnErrorBanner();
    } else if (tokenData.data != null) {
      await _showOnSuccessBanner();

      final jwt = JWTPayloadModel.fromJson(tokenData.data);
      locator<GetBlockchainNFCData>().call(int.parse(jwt.tokenID));
      locator<PushNextScreen>().call(MarketDetailsScreen.screenIndex);
    }
  }

  Future<void> _showOnErrorBanner() async {
    setState(() {
      _isScannerBannerActive = true;
      _isNFCError = true;
    });

    await Future.delayed(const Duration(seconds: 4)).then((value) {
      _onCloseBannerHandler();
    });
  }

  Future<void> _showOnSuccessBanner() async {
    setState(() {
      _isScannerBannerActive = true;
      _isNFCError = false;
    });

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted && _isScannerBannerActive) {
        setState(() {
          _isScannerBannerActive = false;
        });
      }
    });
  }

  void _onCloseBannerHandler() {
    if (mounted && _isScannerBannerActive) {
      setState(() {
        _isScannerBannerActive = false;
      });
      _listenNFC();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenCenter = (mq.size.height - mq.viewPadding.top) * 0.5;

    final wrapperVerticalPadding = mq.viewPadding.top +
        StyleConstants.kDefaultPadding +
        ScaffoldWrapper.getLabelSize(context);
    final scannerTextWidth = SaltPulseAnimation.getLogoSize(context) * 0.65;
    const bannerHeight = StyleConstants.kDefaultButtonSize * 1.2;

    final scannerTextSize = TextPainter(
      text: TextSpan(
        text: 'CLOSE TO NFC TAG',
        style: StyleConstants.kGetDefaultTextStyle(context),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return ContentWrapper(
      widget: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: screenCenter -
                    wrapperVerticalPadding -
                    SaltPulseAnimation.getLogoSize(context) * 0.5,
                child: const SaltPulseAnimation(),
              ),
              Positioned(
                top: screenCenter -
                    wrapperVerticalPadding -
                    scannerTextSize.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: scannerTextWidth,
                      child: const Text(
                        'PULL YOUR PHONE',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: scannerTextWidth,
                      child: const Text(
                        'CLOSE TO NFC TAG',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: ScaffoldWrapper.getBottomCurtainSize(context) +
                    StyleConstants.kDefaultPadding * 1.5,
                right: 0.0,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset(
                        'assets/icons/nfc.png',
                        fit: BoxFit.fill,
                        color: _isNFCAvailable
                            ? StyleConstants.kHyperLinkColor
                            : StyleConstants.kInactiveColor,
                      ),
                    ),
                    const SizedBox(
                      height: StyleConstants.kDefaultPadding * 0.4,
                    ),
                    Text(
                      _isNFCAvailable ? 'NFC ONSITE' : 'NFC UNABLE',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: _isNFCAvailable
                            ? StyleConstants.kHyperLinkColor
                            : StyleConstants.kInactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (_isScannerBannerActive)
                Positioned(
                  top: screenCenter -
                      wrapperVerticalPadding -
                      (bannerHeight * 0.5),
                  child: NFCResponseBanner(
                    height: bannerHeight,
                    width: constraints.maxWidth,
                    isError: _isNFCError,
                    callback: _onCloseBannerHandler,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
