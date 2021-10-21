import 'package:nfc_mobile_prototype/domain/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/domain/models/usecase.dart';
import 'package:nfc_mobile_prototype/domain/services/logger.dart';
import 'package:nfc_mobile_prototype/domain/services/nfc_service.dart';

class WriteNFCTag implements Usecase<void, String> {
  final AppBloc bloc;
  final NFCService nfcService;

  WriteNFCTag({
    required this.bloc,
    required this.nfcService,
  });

  @override
  Future<void> call(String message) async {
    logDebug('WriteNFCTag usecase -> call()');
    var nfcResult = await nfcService.writeTag(message);
    nfcResult.fold(
      (failure) => null,
      (result) => null,
    );
  }
}
