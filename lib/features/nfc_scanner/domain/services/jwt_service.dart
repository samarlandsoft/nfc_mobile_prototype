import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:nfc_mobile_prototype/core/models/failures.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';

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
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );

    final token = jwt.sign(SecretKey(_salt));
    logDebug('Token: $token');
    return token;
  }

  Either<Failure, dynamic> verifyToken(String token) {
    logDebug('JWTService -> verifyToken($token)');
    try {
      final jwt = JWT.verify(token, SecretKey(_salt));
      logDebug('Token verified, payload: ${jwt.payload}');
      return Right(jwt.payload);
    } on JWTExpiredError {
      logDebug('Exception: JWT expired');
    } on JWTError catch (ex) {
      logDebug('Exception: ${ex.runtimeType}');
      logDebug(ex.message);
    }

    return Left(CommonFailure(''));
  }
}
