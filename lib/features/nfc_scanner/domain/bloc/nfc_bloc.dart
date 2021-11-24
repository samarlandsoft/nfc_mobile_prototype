import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_evets.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_state.dart';

class NFCBloc extends Bloc<NFCBlocEvent, NFCBlocState> {
  NFCBloc(NFCBlocState initialState) : super(initialState);

  @override
  Stream<NFCBlocState> mapEventToState(NFCBlocEvent event) async* {
    logDebug('NFCBloc -> mapEventToState(${event.runtimeType})');

    switch (event.runtimeType) {
      case NFCReadChipEvent: {
        var snapshot = event as NFCReadChipEvent;
        yield state.update(token: snapshot.token);
        break;
      }
    }
  }
}