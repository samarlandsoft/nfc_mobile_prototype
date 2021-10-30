import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';

class WriteNFCData implements Usecase<void, String> {
  final NFCBloc bloc;
  final NFCService nfcService;

  WriteNFCData({
    required this.bloc,
    required this.nfcService,
  });

  @override
  Future<void> call(String message) async {
    logDebug('WriteNFCData usecase -> call()');
    var nfcResult = await nfcService.writeTag(message);
    nfcResult.fold(
      (failure) => null,
      (result) => null,
    );
  }
}
