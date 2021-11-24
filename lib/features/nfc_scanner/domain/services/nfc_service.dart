import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/core/models/failures.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/jwt_payload.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/nfc_failures.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_service.dart';

class NFCService {
  final NfcManager _nfcManager = NfcManager.instance;
  final JWTService jwtService;
  bool _isBusy = false;

  NFCService({required this.jwtService});

  Future<Either<Failure, Ndef>> readTag() async {
    logDebug('NFCService -> readTag()');

    if (await _checkAvailabilityNfcManager()) {
      return Left(CommonFailure(NFCFailures.failuresMessages[NFCFailureType.serviceBusy]!));
    }

    Ndef? ndef;
    var isScanned = false;

    _nfcManager.startSession(onDiscovered: (NfcTag tag) async {
      ndef = Ndef.from(tag);
      isScanned = true;
      await _nfcManager.stopSession();
    });

    while (!isScanned) {
      await Future.delayed(const Duration(seconds: 1));
    }

    _isBusy = false;
    return ndef != null ? Right(ndef!) : Left(CommonFailure(NFCFailures.failuresMessages[NFCFailureType.notValidNDEF]!));
  }

  Future<Either<Failure, bool>> writeTag(String tokenID) async {
    logDebug('NFCService -> writeTag($tokenID)');

    if (await _checkAvailabilityNfcManager()) {
      return Left(CommonFailure(NFCFailures.failuresMessages[NFCFailureType.serviceBusy]!));
    }

    var hasException = false;
    var isScanned = false;

    _nfcManager.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);

      if (ndef == null || !ndef.isWritable) {
        if (ndef == null) {
          logDebug('Error: Ndef is null');
        } else {
          logDebug('Error: Ndef isn\'t writable');
        }
        hasException = true;
        isScanned = true;
        await _nfcManager.stopSession();
        return;
      }

      var payload = JWTPayloadModel(
        tokenID: tokenID,
        chipID: getChipID(ndef.additionalData['identifier'] as Uint8List),
      );
      var jwt = jwtService.generateToken(payload.toJson());

      var message = NdefMessage([
        NdefRecord.createText(jwt),
      ]);

      try {
        await ndef.write(message);
        logDebug('Success: Message "$jwt" was recorded');
      } catch (e) {
        hasException = true;
        logDebug('Exception: Error when trying to record a message');
        logDebug('Exception: $e');
      }

      isScanned = true;
      await _nfcManager.stopSession();
    });

    while (!isScanned) {
      await Future.delayed(const Duration(seconds: 1));
    }

    _isBusy = false;
    return hasException ? Left(CommonFailure('')) : const Right(true);
  }

  Future<bool> _checkAvailabilityNfcManager() async {
    if (_isBusy) {
      logDebug('Error: NFCService is busy right now');
      _isBusy = false;
      await _nfcManager.stopSession();
      return true;
    } else {
      _isBusy = true;
      return false;
    }
  }

  Future<bool> checkNFCAvailable() async {
    var isAvailable = await _nfcManager.isAvailable();
    if (!isAvailable) {
      logDebug('Error: NFCService isn\'t available');
    }
    return isAvailable;
  }

  String getChipID(Uint8List bytes) {
    logDebug('NFCService -> getChipID()');
    return bytes.fold<String>('', (previousValue, element) {
      return previousValue += element.toRadixString(16);
    });
  }

  Future<void> cancelScanning() async {
    logDebug('NFCService -> cancelScanning()');
    _isBusy = false;
    await _nfcManager.stopSession();
  }
}
