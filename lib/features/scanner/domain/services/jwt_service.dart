import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:nfc_mobile_prototype/core/models/failures.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/nfc_failures.dart';

class JWTService {
  static const _version = '1';
  static const _salt = '12345';

  String generateToken(Map<String, dynamic> data) {
    logDebug('JWTService -> generateToken()');
    final jwt = JWT(
      data,
      header: {
        'alg': 'HS256',
        'typ': 'JWT',
        'version': _version,
      },
    );

    final token = jwt.sign(SecretKey(_salt), noIssueAt: true);
    logDebug('Token: $token');
    return token;
  }

  Either<Failure, dynamic> verifyToken(String token, String chipID) {
    logDebug('JWTService -> verifyToken($token)');
    try {
      final jwt = JWT.verify(token, SecretKey(_salt));

      if (jwt.payload != null && jwt.payload?['chipID'] == chipID) {
        logDebug('Token verified, payload: ${jwt.payload}');
        return Right(jwt.payload);
      } else {
        logDebug('Token verified, payload: ${jwt.payload}');
        return Left(CommonFailure(NFCFailures.failuresMessages[NFCFailureType.notValidChip]!));
      }
    } on JWTExpiredError {
      logDebug('Exception: JWT expired');
    } on JWTError catch (e) {
      logDebug('Exception: ${e.runtimeType}');
      logDebug(e.message);
    } on FormatException catch (e) {
      logDebug('Exception: ${e.runtimeType}');
      logDebug(e.message);
      return Left(CommonFailure(NFCFailures.failuresMessages[NFCFailureType.notValidJWT]!));
    }

    return Left(CommonFailure(''));
  }
}
