import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc_evets.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';

class ReadNFCData implements Usecase<void, NoParams> {
  final NFCBloc bloc;
  final NFCService nfcService;
  final JWTService jwtService;

  const ReadNFCData({
    required this.bloc,
    required this.nfcService,
    required this.jwtService,
  });

  @override
  Future<void> call(NoParams params) async {
    logDebug('ReadNFCData usecase -> call()');
    var nfcResult = await nfcService.readTag();
    nfcResult.fold(
      (failure) => null,
      (result) {
        if (result.cachedMessage != null &&
            result.cachedMessage!.records.isNotEmpty) {

          var payload = result.cachedMessage!.records[0].payload;
          var data = String.fromCharCodes(payload).substring(3);

          logDebug('Payload in chip: $payload');
          logDebug('Data in chip: $data');

          jwtService.verifyToken(data);
        }

        bloc.add(NFCReadChipEvent(ndef: result));
      },
    );
  }
}
