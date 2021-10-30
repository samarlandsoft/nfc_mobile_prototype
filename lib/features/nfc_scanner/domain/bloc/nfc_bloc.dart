import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc_evets.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc_state.dart';

class NFCBloc extends Bloc<NFCBlocEvent, NFCBlocState> {
  NFCBloc(NFCBlocState initialState) : super(initialState);

  @override
  Stream<NFCBlocState> mapEventToState(NFCBlocEvent event) async* {
    switch (event.runtimeType) {
      case NFCReadChipEvent: {
        var snapshot = event as NFCReadChipEvent;
        yield state.update(ndef: snapshot.ndef);
        break;
      }
    }
  }
}