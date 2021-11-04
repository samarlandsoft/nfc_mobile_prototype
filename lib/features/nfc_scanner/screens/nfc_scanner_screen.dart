import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/widgets/rounded_button.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_data_props.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/product_details_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_state.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/jwt_mock_database.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/jwt_payload.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/read_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/show_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/write_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_details_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/animated_loader.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/widgets/animated_pulse.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class NfcScannerScreen extends StatefulWidget {
  static const index = 1;

  const NfcScannerScreen({Key? key}) : super(key: key);

  @override
  State<NfcScannerScreen> createState() => _NfcScannerScreenState();
}

class _NfcScannerScreenState extends State<NfcScannerScreen> {
  bool _isInit = false;
  bool _isScanning = false;
  bool _isWriting = false;
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
      });
    }
  }

  void _onShowNFCButtonHandler() async {
    if (_isScanning || _isWriting) return;

    setState(() {
      _isScanning = true;
    });
    var tokenData = await locator<ShowNFCData>().call(NoParams());
    setState(() {
      _isScanning = false;
    });

    if (tokenData != null) {
      var jwt = JWTPayloadModel.fromJson(tokenData);

      Navigator.of(context).pushNamed(
        ProductDetailsScreen.routeName,
        arguments: NFCDataProps(
          sweater: NFCSweater(
            title: 'TEST TITLE',
            edition: 'TEST EDITION',
            description: 'TEST DESCRIPTION',
            tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
            currency: CryptoCurrency.none,
            chipSrc: JWTMockDatabase.sweaterURLs[jwt.tokenID],
          ),
          fromToken: true,
        ),
      );
    }
  }

  void _onReadNFCButtonHandler() async {
    if (_isScanning || _isWriting) return;

    setState(() {
      _isScanning = true;
    });
    await locator<ReadNFCData>().call(NoParams());
    setState(() {
      _isScanning = false;
    });
  }

  void _onWriteNFCButtonHandler() async {
    if (_isScanning || _isWriting) return;

    setState(() {
      _isWriting = true;
    });

    var isSuccess = await locator<WriteNFCData>().call('2');

    setState(() {
      _isWriting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
        _buildSnackBar(isSuccess ? 'Token is recorded!' : 'Failed to record!'));
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

      if (_isWriting) {
        description = 'Writing...';
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
      backgroundColor: Colors.white,
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
    final loaderSize = mq.size.width * 0.5;
    final descriptionWidth = mq.size.width * 0.7;

    final scannerPosition = (mq.size.height / 2.0) -
        (loaderSize / 2.0) -
        mq.viewPadding.top -
        StyleConstants.kBottomBarHeight;
    final descriptionPosition = scannerPosition - (loaderSize / 2.0);

    return BlocListener<NFCBloc, NFCBlocState>(
      listener: (context, state) {
        if (state.ndef != null) {
          _showNFCDetails(state.ndef!);
        }
      },
      child: ContentWrapper(
        backgroundSrc: 'assets/images/background_2.png',
        widget: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (!_isScanning && !_isWriting)
              Positioned(
                bottom: scannerPosition,
                child: AnimatedLoader(
                  height: loaderSize,
                  width: loaderSize,
                ),
              ),
            if (_isScanning || _isWriting)
              Positioned(
                bottom: scannerPosition,
                child: AnimatedPulse(
                  height: loaderSize,
                  width: loaderSize,
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
              left: StyleConstants.kDefaultPadding,
              child: AbsorbPointer(
                absorbing: !_isNFCAvailable,
                child: Row(
                  children: <Widget>[
                    RoundedButton(
                      icon: Icons.remove_red_eye,
                      isTapped: _isScanning,
                      callback: _onShowNFCButtonHandler,
                    ),
                    const SizedBox(
                      width: StyleConstants.kDefaultPadding,
                    ),
                    RoundedButton(
                      icon: Icons.my_library_books_outlined,
                      isTapped: _isScanning,
                      callback: _onReadNFCButtonHandler,
                    ),
                    const SizedBox(
                      width: StyleConstants.kDefaultPadding,
                    ),
                    RoundedButton(
                      icon: Icons.edit,
                      isTapped: _isWriting,
                      callback: _onWriteNFCButtonHandler,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
