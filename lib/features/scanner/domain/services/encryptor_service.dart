import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/chip_payload.dart';

class EncryptorService {
  static const _salt = '12345';

  String _generateToken(ChipPayload payload) {
    logDebug('EncryptorService -> generateToken()');
    final token = md5.convert(utf8.encode(payload.toString() + _salt));
    logDebug('Token: ${token.toString()}');
    return token.toString();
  }

  bool verifyToken(String record, ChipPayload payload) {
    logDebug('EncryptorService -> verifyToken($record)');
    final token = _generateToken(payload);
    return record == '${payload.tokenID}.$token';
  }
}
