import 'package:dartz/dartz.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/domain/models/failures.dart';
import 'package:nfc_mobile_prototype/domain/services/logger.dart';

class NFCService {
  final NfcManager _nfcManager = NfcManager.instance;

  Future<Either<Failure, Map<String, dynamic>>> readTag() async {
    logDebug('NFCService -> readTag()');
    Map<String, dynamic> tagData = {};
    var isScanned = false;
    var isAvailable = await _nfcManager.isAvailable();

    if (!isAvailable) {
      logDebug('Error: NfcManager isn\'t available');
      return Left(CommonFailure(''));
    }

    _nfcManager.startSession(onDiscovered: (NfcTag tag) async {
      tagData = tag.data;
      isScanned = true;
      logDebug('Tag data: $tagData');
      _nfcManager.stopSession();
    });

    while (!isScanned) {
      await Future.delayed(const Duration(seconds: 1));
    }
    return Right(tagData);
  }

  Future<Either<Failure, bool>> writeTag(String text) async {
    logDebug('NFCService -> writeTag()');
    var hasException = false;
    var isScanned = false;
    var isAvailable = await _nfcManager.isAvailable();

    if (!isAvailable) {
      logDebug('Error: NfcManager isn\'t available');
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
        _nfcManager.stopSession();
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
      _nfcManager.stopSession();
    });

    while (!isScanned) {
      await Future.delayed(const Duration(seconds: 1));
    }
    return hasException ? Left(CommonFailure('')) : const Right(true);
  }
}
