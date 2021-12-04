import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scaffold_wrapper.dart';
import 'package:nfc_mobile_prototype/locator.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_active_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/datasources/jwt_mock_database.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/jwt_payload.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/usecases/read_nfc_chip.dart';
import 'package:nfc_mobile_prototype/features/scanner/widgets/salt_pulse_animation.dart';

class ScannerScreen extends StatefulWidget {
  static const screenIndex = 2;

  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _isInit = false;
  bool _isNFCAvailable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<NFCService>().checkNFCAvailable().then((value) {
        setState(() {
          _isInit = true;
          _isNFCAvailable = value;
        });

        _listenNFC();
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

    if (tokenData.data != null) {
      var jwt = JWTPayloadModel.fromJson(tokenData.data);
      var chipUrl = JWTMockDatabaseTemp.sweaterTokenURLs[jwt.tokenID]!;
      var isBTCEdition = int.parse(jwt.tokenID) > 22;
      var amountSoldSweaters = locator<JWTMockDatabaseTemp>()
          .getAmountSoldSweaters(chipUrl, isBTCEdition);

      locator<UpdateMarketActiveSweater>().call(
        NFCSweater(
          tokenID: int.parse(jwt.tokenID),
          title: 'Season 1 Can\'t Be Stopped',
          edition: isBTCEdition ? 'Bitcoin Edition' : 'Ethereum Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          currency: isBTCEdition ? CryptoCurrency.btc : CryptoCurrency.eth,
          chipSrc: chipUrl,
          qrSrc: 'assets/images/qr_code.png',
          amount: 20,
          sold: amountSoldSweaters,
        ),
      );
      locator<UpdateScreenIndex>().call(MarketDetailsScreen.screenIndex);
      locator<UpdateWrapperCurtainMode>().call(
        NoParams(),
        isTopCurtainEnabled: true,
        isBottomCurtainEnabled: true,
      );
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

    final scannerTextSize = TextPainter(
      text: const TextSpan(
        text: 'CLOSE TO NFC TAG',
        style: StyleConstants.kDefaultTextStyle,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return ContentWrapper(
      widget: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: screenCenter -
                wrapperVerticalPadding -
                SaltPulseAnimation.getLogoSize(context) * 0.5,
            child: const SaltPulseAnimation(),
          ),
          Positioned(
            top: screenCenter - wrapperVerticalPadding - scannerTextSize.height,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: (scannerTextWidth - scannerTextSize.width) * 0.5,
                    ),
                    SizedBox(
                      width: scannerTextWidth,
                      child: const Text('PULL YOUR PHONE'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: (scannerTextWidth - scannerTextSize.width) * 0.5,
                    ),
                    SizedBox(
                      width: scannerTextWidth,
                      child: const Text('CLOSE TO NFC TAG'),
                    ),
                  ],
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
                  'NFC ONSITE',
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
        ],
      ),
    );
  }
}
