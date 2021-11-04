import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';

class WriteNFCData implements Usecase<bool, String> {
  final NFCBloc bloc;
  final NFCService nfcService;

  const WriteNFCData({
    required this.bloc,
    required this.nfcService,
  });

  @override
  Future<bool> call(String tokenID) async {
    logDebug('WriteNFCData usecase -> call($tokenID)');
    var nfcResult = await nfcService.writeTag(tokenID);

    return nfcResult.fold(
      (failure) => false,
      (result) => true,
    );
  }
}
