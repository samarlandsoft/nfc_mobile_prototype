import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';

class WriteNFCData implements Usecase<void, Map<String, dynamic>> {
  final NFCBloc bloc;
  final NFCService nfcService;
  final JWTService jwtService;

  WriteNFCData({
    required this.bloc,
    required this.nfcService,
    required this.jwtService,
  });

  @override
  Future<void> call(Map<String, dynamic> payload) async {
    logDebug('WriteNFCData usecase -> call()');
    var message = jwtService.generateToken(payload);

    var nfcResult = await nfcService.writeTag(message);
    nfcResult.fold(
      (failure) => null,
      (result) => null,
    );
  }
}
