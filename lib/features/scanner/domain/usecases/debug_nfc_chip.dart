import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_bloc.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_events.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_state.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/chip_payload.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/nfc_failures.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/nfc_response_data.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/services/encryptor_service.dart';

class DebugNFCChip implements Usecase<NFCResponseData, DebugBlocState> {
  final DebugBloc debugBloc;
  final EncryptorService encryptorService;

  const DebugNFCChip({
    required this.debugBloc,
    required this.encryptorService,
  });

  @override
  Future<NFCResponseData> call(DebugBlocState debugPayload) async {
    logDebug('DebugNFCChip usecase -> call()');
    debugBloc.add(DebugUpdateData(
      chipID: debugPayload.chipID!,
      tokenID: debugPayload.tokenID!,
      md5Hash: debugPayload.md5Hash!,
    ));

    var isSuccess = false;
    String? errorMessage;
    int? tokenData;

    var chipRecord = '${debugPayload.tokenID}.${debugPayload.md5Hash}';
    var payload = ChipPayload(
      tokenID: chipRecord.split('.').first,
      chipID: debugPayload.chipID!,
    );

    var cryptoResult = encryptorService.verifyToken(chipRecord, payload);
    if (cryptoResult) {
      isSuccess = true;
      tokenData = int.parse(payload.tokenID);
    } else {
      errorMessage = NFCFailures.failuresMessages[NFCFailureType.notValidChip];
    }

    return NFCResponseData(
      isSuccess: isSuccess,
      tokenID: tokenData,
      error: errorMessage,
    );
  }
}
