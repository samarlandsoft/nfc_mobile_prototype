import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc_evets.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';

class ReadNFCData implements Usecase<void, NoParams> {
  final NFCBloc bloc;
  final NFCService nfcService;

  ReadNFCData({
    required this.bloc,
    required this.nfcService,
  });

  @override
  Future<void> call(NoParams params) async {
    logDebug('ReadNFCData usecase -> call()');
    var nfcResult = await nfcService.readTag();
    nfcResult.fold(
      (failure) => null,
      (result) {
        bloc.add(NFCReadChipEvent(ndef: result));
      },
    );
  }
}
