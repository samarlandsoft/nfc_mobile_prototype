import 'package:nfc_mobile_prototype/domain/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/domain/models/usecase.dart';
import 'package:nfc_mobile_prototype/domain/services/logger.dart';
import 'package:nfc_mobile_prototype/domain/services/nfc_service.dart';

class ReadNFCTag implements Usecase<void, NoParams> {
  final AppBloc bloc;
  final NFCService nfcService;

  ReadNFCTag({
    required this.bloc,
    required this.nfcService,
  });

  @override
  Future<void> call(NoParams params) async {
    logDebug('ReadNFCTag usecase -> call()');
    var nfcResult = await nfcService.readTag();
    nfcResult.fold(
      (failure) => null,
      (result) {
        if (result.isNotEmpty) {
          bloc.add(AppReadTag(
              tag: '${result.keys.toList()[0]} - ${result.values.toList()[0]}'));
        }
      },
    );
  }
}
