import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_events.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_state.dart';

class DebugBloc extends Bloc<DebugBlocEvent, DebugBlocState> {
  DebugBloc(DebugBlocState initialState) : super(initialState);

  @override
  Stream<DebugBlocState> mapEventToState(DebugBlocEvent event) async* {
    logDebug('DebugBloc -> mapEventToState(${event.runtimeType})');

    switch (event.runtimeType) {
      case DebugUpdateData:
        {
          var snapshot = event as DebugUpdateData;
          yield state.update(
            tagID: snapshot.chipID,
            tokenID: snapshot.tokenID,
            md5Hash: snapshot.md5Hash,
          );
          break;
        }
    }
  }
}
