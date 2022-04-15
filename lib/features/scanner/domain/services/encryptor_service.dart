import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/chip_payload.dart';

class EncryptorService {
  static const _salt = '12345';

  bool verifyToken(String record, ChipPayload payload) {
    logDebug('EncryptorService -> verifyToken($record)');
    final token = md5.convert(utf8.encode(payload.toString() + _salt));
    logDebug('Token: ${token.toString()}');
    return record == '${payload.tokenID}.$token';
  }
}
