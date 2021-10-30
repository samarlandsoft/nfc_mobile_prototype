import 'package:dartz/dartz.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/core/models/failures.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';

class NFCService {
  final NfcManager _nfcManager = NfcManager.instance;
  bool _isBusy = false;

  Future<Either<Failure, Ndef>> readTag() async {
    logDebug('NFCService -> readTag()');

    if (await _checkAvailabilityNfcManager()) {
      return Left(CommonFailure(''));
    }

    Ndef? ndef;
    var isScanned = false;
    var isAvailable = await _nfcManager.isAvailable();

    if (!isAvailable) {
      logDebug('Error: NfcManager isn\'t available');
      _isBusy = false;
      return Left(CommonFailure(''));
    }

    _nfcManager.startSession(onDiscovered: (NfcTag tag) async {
      ndef = Ndef.from(tag);
      isScanned = true;
      await _nfcManager.stopSession();
    });

    while (!isScanned) {
      await Future.delayed(const Duration(seconds: 1));
    }

    _isBusy = false;
    return ndef != null ? Right(ndef!) : Left(CommonFailure(''));
  }

  Future<Either<Failure, bool>> writeTag(String text) async {
    logDebug('NFCService -> writeTag()');

    if (await _checkAvailabilityNfcManager()) {
      return Left(CommonFailure(''));
    }

    var hasException = false;
    var isScanned = false;
    var isAvailable = await _nfcManager.isAvailable();

    if (!isAvailable) {
      logDebug('Error: NfcManager isn\'t available');
      _isBusy = false;
      return Left(CommonFailure(''));
    }

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

      var message = NdefMessage([
        NdefRecord.createText(text),
      ]);

      try {
        await ndef.write(message);
        logDebug('Success: Message "$text" was recorded');
      } catch (e) {
        hasException = true;
        logDebug('Exception: Error when trying to record a message');
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
      logDebug('Error: NfcManager is busy right now');
      _isBusy = false;
      await _nfcManager.stopSession();
      return true;
    } else {
      _isBusy = true;
      return false;
    }
  }
}
