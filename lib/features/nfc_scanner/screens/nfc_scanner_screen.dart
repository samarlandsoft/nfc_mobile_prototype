import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/widgets/app_icon.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater_props.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/product_details_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_state.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/jwt_payload.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_mock_database.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/read_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/show_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_details_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/widgets/animated_ripple.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class NFCScannerScreen extends StatefulWidget {
  static const String titleName = 'Scan NFC';
  static const int screenIndex = 3;

  const NFCScannerScreen({Key? key}) : super(key: key);

  @override
  State<NFCScannerScreen> createState() => _NFCScannerScreenState();
}

class _NFCScannerScreenState extends State<NFCScannerScreen> {
  bool _isInit = false;
  bool _isScanning = false;
  bool _isReading = false;
  bool _isNFCAvailable = false;
  bool _isNFCTagAvailable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<NFCService>().checkNFCAvailable().then((value) {
        setState(() {
          _isInit = true;
          _isNFCAvailable = value;
        });
      });
    }
  }

  @override
  void dispose() {
    locator<NFCService>().cancelScanning();
    super.dispose();
  }

  void _onScanNFCButtonHandler() async {
    if (_isScanning) {
      await locator<NFCService>().cancelScanning();
      setState(() {
        _isScanning = false;
      });
      return;
    }

    if (_isReading) {
      await locator<NFCService>().cancelScanning();
      setState(() {
        _isReading = false;
      });
    }

    setState(() {
      _isScanning = true;
      _isNFCTagAvailable = false;
    });
    var tokenData = await locator<ShowNFCData>().call(NoParams());
    setState(() {
      _isScanning = false;
    });

    if (tokenData.error != null && tokenData.error != '') {
      _buildSnackBar(tokenData.error!);
    } else if (tokenData.data != null) {
      var jwt = JWTPayloadModel.fromJson(tokenData.data);
      var chipUrl = JWTMockDatabase.sweaterTokenURLs[jwt.tokenID]!;
      var isBTCEdition = int.parse(jwt.tokenID) > 22;
      var amountSoldSweaters = locator<JWTMockDatabase>()
          .getAmountSoldSweaters(chipUrl, isBTCEdition);

      setState(() {
        _isNFCTagAvailable = true;
      });

      Navigator.of(context).pushNamed(
        ProductDetailsScreen.routeName,
        arguments: NFCSweaterProps(
          sweater: NFCSweater(
            tokenID: int.parse(jwt.tokenID),
            title: isBTCEdition
                ? 'Season 1 Can\'t Be Stopped - Bitcoin Edition'
                : 'Season 1 Can\'t Be Stopped - Ethereum Edition',
            edition: isBTCEdition ? 'Bitcoin Edition' : 'Ethereum Edition',
            description:
                'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
            tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
            currency: CryptoCurrency.none,
            chipSrc: chipUrl,
            amount: 20,
            sold: amountSoldSweaters,
          ),
          fromToken: true,
        ),
      );
    }
  }

  void _onReadNFCButtonHandler() async {
    if (_isReading) {
      await locator<NFCService>().cancelScanning();
      setState(() {
        _isReading = false;
      });
      return;
    }

    if (_isScanning) {
      await locator<NFCService>().cancelScanning();
      setState(() {
        _isScanning = false;
      });
    }

    setState(() {
      _isReading = true;
      _isNFCTagAvailable = false;
    });
    var tokenData = await locator<ReadNFCData>().call(NoParams());
    setState(() {
      _isReading = false;
    });

    if (tokenData.isSuccess) {
      setState(() {
        _isNFCTagAvailable = true;
      });
    }
  }

  SnackBar _buildSnackBar(String message) {
    return SnackBar(
      duration: const Duration(seconds: 4),
      content: Text(
        message,
      ),
    );
  }

  Widget _buildScannerDescription() {
    var description = 'Checking availability of the scanner';

    if (_isInit && _isNFCAvailable) {
      description = 'Pull your phone close to NFC tag';
    }

    if (_isInit && !_isNFCAvailable) {
      description = 'Your phone doesn\'t support NFC or is not turn on';
    } else {
      if (_isScanning) {
        description = 'Scanning...';
      }

      if (_isReading) {
        description = 'Reading...';
      }
    }

    return Text(
      description,
      style: const TextStyle(
        fontSize: 24.0,
      ),
      textAlign: TextAlign.center,
      maxLines: 4,
    );
  }

  void _showNFCDetails(Ndef ndef) {
    showModalBottomSheet(
      backgroundColor: StyleConstants.kBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(StyleConstants.kDefaultPadding)),
      ),
      enableDrag: false,
      context: context,
      builder: (context) {
        return NFCDetailsScreen(ndef: ndef);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final iconSize = mq.size.width * 0.24;
    final animationSize = mq.size.width * 0.5;
    final descriptionWidth = mq.size.width * 0.7;

    final iconPosition =
        (mq.size.height / 2.0) - (iconSize / 2.0) - mq.viewPadding.top;
    final scannerPosition =
        (mq.size.height / 2.0) - (animationSize / 2.0) - mq.viewPadding.top;
    final descriptionPosition = scannerPosition - (animationSize / 2.0);

    return BlocConsumer<NFCBloc, NFCBlocState>(
      listenWhen: (prev, current) {
        return prev.token != current.token;
      },
      buildWhen: (prev, current) {
        return prev.token != current.token;
      },
      listener: (context, state) {
        if (state.token != null) {
          _showNFCDetails(state.token!.ndef);
        }
      },
      builder: (context, state) {
        return ContentWrapper(
          title: NFCScannerScreen.titleName,
          backgroundSrc: 'assets/images/background_3.png',
          withNavigation: true,
          widget: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              if (_isNFCTagAvailable && state.token != null)
                Positioned(
                  top: 0.0,
                  child: Text(
                    'Chip ID: ${state.token!.tokenID}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              Positioned(
                bottom: scannerPosition,
                child: BlocBuilder<AppBloc, AppBlocState>(
                  buildWhen: (prev, current) {
                    return prev.isCustomTheme != current.isCustomTheme;
                  },
                  builder: (context, state) {
                    return AnimatedRipple(
                      height: animationSize,
                      width: animationSize,
                      radius: (_isScanning || _isReading)
                          ? iconSize * 0.7
                          : iconSize * 0.28,
                      count: (_isScanning || _isReading) ? 4 : 6,
                      color: state.isCustomTheme
                          ? StyleConstants.kHyperlinkTextColor
                          : Colors.white,
                      duration: 3000,
                    );
                  },
                ),
              ),
              Positioned(
                bottom: iconPosition,
                child: AppIcon(
                  height: iconSize,
                  width: iconSize,
                ),
              ),
              Positioned(
                bottom: descriptionPosition,
                child: SizedBox(
                  width: descriptionWidth,
                  child: _buildScannerDescription(),
                ),
              ),
              Positioned(
                bottom: StyleConstants.kDefaultPadding,
                right: StyleConstants.kDefaultPadding,
                child: AbsorbPointer(
                  absorbing: true,
                  child: NeonButton(
                    imageSrc: 'assets/icons/nfc.png',
                    callback: () {},
                    isRounded: true,
                    isTapped: _isNFCAvailable,
                    activeColor: StyleConstants.kHyperlinkTextColor,
                  ),
                ),
              ),
              Positioned(
                bottom: StyleConstants.kDefaultPadding,
                left: StyleConstants.kDefaultPadding,
                child: AbsorbPointer(
                  absorbing: !_isNFCAvailable,
                  child: Row(
                    children: <Widget>[
                      NeonButton(
                        icon: _isScanning ? Icons.stop : Icons.play_arrow,
                        callback: _onScanNFCButtonHandler,
                        isRounded: true,
                        isTapped: _isScanning,
                      ),
                      BlocBuilder<AppBloc, AppBlocState>(
                        buildWhen: (prev, current) {
                          return prev.isDebugEnabled != current.isDebugEnabled;
                        },
                        builder: (context, state) {
                          return state.isDebugEnabled
                              ? Row(
                                  children: [
                                    const SizedBox(
                                      width: StyleConstants.kDefaultPadding,
                                    ),
                                    NeonButton(
                                      icon: Icons.my_library_books_outlined,
                                      callback: _onReadNFCButtonHandler,
                                      isRounded: true,
                                      isTapped: _isReading,
                                    ),
                                  ],
                                )
                              : const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
