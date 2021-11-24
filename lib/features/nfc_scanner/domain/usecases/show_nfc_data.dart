import 'dart:typed_data';

import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_evets.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/nfc_response_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/nfc_token.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';

class ShowNFCData implements Usecase<NFCResponseData, NoParams> {
  final NFCBloc bloc;
  final NFCService nfcService;
  final JWTService jwtService;

  const ShowNFCData({
    required this.bloc,
    required this.nfcService,
    required this.jwtService,
  });

  @override
  Future<NFCResponseData> call(NoParams params) async {
    logDebug('ShowNFCData usecase -> call()');

    var isSuccess = false;
    String? errorMessage;
    dynamic tokenData;
    var nfcResult = await nfcService.readTag();

    nfcResult.fold(
      (failure) {
        errorMessage = failure.error;
      },
      (token) {
        if (token.cachedMessage != null &&
            token.cachedMessage!.records.isNotEmpty) {
          var payload = token.cachedMessage!.records[0].payload;
          var jwt = String.fromCharCodes(payload).substring(3);

          logDebug('Payload in chip: $payload');
          logDebug('JWT in chip: $jwt');

          var chipID = nfcService
              .getChipID(token.additionalData['identifier'] as Uint8List);
          var data = jwtService.verifyToken(jwt, chipID);
          data.fold(
            (failure) {
              errorMessage = failure.error;
              bloc.add(NFCReadChipEvent(
                  token: NFCToken(
                tokenID: chipID,
                ndef: token,
              )));
            },
            (result) {
              isSuccess = true;
              tokenData = result;
            },
          );
        }
      },
    );

    return NFCResponseData(
      isSuccess: isSuccess,
      data: tokenData,
      error: errorMessage,
    );
  }
}
