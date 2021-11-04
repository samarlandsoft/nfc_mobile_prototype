import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_evets.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';

class ReadNFCData implements Usecase<bool, NoParams> {
  final NFCBloc bloc;
  final NFCService nfcService;
  final JWTService jwtService;

  const ReadNFCData({
    required this.bloc,
    required this.nfcService,
    required this.jwtService,
  });

  @override
  Future<bool> call(NoParams params) async {
    logDebug('ReadNFCData usecase -> call()');

    var isSuccess = false;
    var nfcResult = await nfcService.readTag();

    nfcResult.fold(
      (failure) => null,
      (token) {
        if (token.cachedMessage != null &&
            token.cachedMessage!.records.isNotEmpty) {
          var payload = token.cachedMessage!.records[0].payload;
          var jwt = String.fromCharCodes(payload).substring(3);

          logDebug('Payload in chip: $payload');
          logDebug('JWT in chip: $jwt');

          var data = jwtService.verifyToken(jwt);
          data.fold(
            (failure) => null,
            (result) {
              isSuccess = true;
              bloc.add(NFCReadChipEvent(ndef: token));
            },
          );
        }
      },
    );

    return isSuccess;
  }
}
