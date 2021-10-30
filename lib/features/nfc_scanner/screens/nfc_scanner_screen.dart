import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc_state.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/read_nfc_data.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/marketplace_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/write_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_details_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/widgets/animated_pulse.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class NfcScannerScreen extends StatefulWidget {
  static const index = 1;

  const NfcScannerScreen({Key? key}) : super(key: key);

  @override
  State<NfcScannerScreen> createState() => _NfcScannerScreenState();
}

class _NfcScannerScreenState extends State<NfcScannerScreen>
    with SingleTickerProviderStateMixin {
  static const _disableDuration = 200;
  static const _logoSize = 150.0;
  static const _iconSize = 45.0;
  late AnimationController _controller;
  bool _isDisabled = false;
  bool _isScanning = false;
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    String message = math.Random().nextInt(100).toString();
    await locator<WriteNFCData>().call(message);
    setState(() {
      _isWriting = false;
    });
  }

  void _onGoNextButtonHandler() {
    setState(() {
      _isDisabled = true;
    });
    Future.delayed(const Duration(milliseconds: _disableDuration ~/ 2))
        .then((_) {
      _controller.stop();
    });
    locator<UpdateScreenIndex>().call(MarketplaceScreen.index);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logoPosition =
        (mq.size.height / 2.0) - (_logoSize / 2.0) - mq.viewPadding.top;
    final iconPosition = logoPosition + (_logoSize / 2.0) - (_iconSize / 2.0);
    final textPosition = logoPosition - (_logoSize / 2.0) - 10.0;

    return BlocListener<NFCBloc, NFCBlocState>(
      listener: (context, state) {
        if (state.ndef != null) {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            enableDrag: false,
            context: context,
            builder: (context) {
              return NFCDetailsScreen(ndef: state.ndef!);
            },
          );
        }
      },
      child: Container(
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
                  child: Text(
                    _isScanning
                        ? 'Scanning...'
                        : _isWriting
                            ? 'Writing...'
                            : 'Scan NFC tag',
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 10.0,
                  child: Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: 'Read',
                        onPressed: _onReadNFCButtonHandler,
                        backgroundColor:
                            _isScanning ? Colors.green : Colors.blue,
                        child: const Icon(Icons.my_library_books_outlined),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      FloatingActionButton(
                        heroTag: 'Write',
                        onPressed: _onWriteNFCButtonHandler,
                        backgroundColor:
                            _isWriting ? Colors.green : Colors.blue,
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 20.0,
                //   child: NeonButton(
                //     label: 'Next',
                //     callback: _onGoNextButtonHandler,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
