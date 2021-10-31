import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/widgets/rounded_button.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc_state.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/jwt_payload.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/read_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/write_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_details_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/widgets/animated_loader.dart';
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
  bool _isScanning = false;
  bool _isWriting = false;

  void _onReadNFCButtonHandler() async {
    if (_isWriting) return;

    setState(() {
      _isScanning = true;
    });
    await locator<ReadNFCData>().call(NoParams());
    setState(() {
      _isScanning = false;
    });
  }

  void _onWriteNFCButtonHandler() async {
    if (_isScanning) return;

    setState(() {
      _isWriting = true;
    });

    var payload = const JWTPayloadModel(
      tokenID: '1',
      data: 'test',
    );
    await locator<WriteNFCData>().call(payload.toJson());

    setState(() {
      _isWriting = false;
    });
  }

  void _showNFCDetails(Ndef ndef) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
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

    final scannerPosition =
        (mq.size.height / 2.0) - (loaderSize / 2.0) - mq.viewPadding.top - 56.0;
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
                child: Text(
                  _isScanning
                      ? 'Scanning...'
                      : _isWriting
                          ? 'Writing...'
                          : 'Pull your phone close to NFC tag',
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: Row(
                children: <Widget>[
                  RoundedButton(
                    icon: Icons.my_library_books_outlined,
                    isTapped: _isScanning,
                    callback: _onReadNFCButtonHandler,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  RoundedButton(
                    icon: Icons.edit,
                    isTapped: _isWriting,
                    callback: _onWriteNFCButtonHandler,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
