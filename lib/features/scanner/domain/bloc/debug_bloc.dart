import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_events.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_state.dart';

class DebugBloc extends Bloc<DebugBlocEvent, DebugBlocState> {
  DebugBloc(DebugBlocState initialState) : super(initialState) {
    on<DebugUpdateData>((event, emit) {
      emit(state.update(
        chipID: event.chipID,
        tokenID: event.tokenID,
        md5Hash: event.md5Hash,
      ));
    });
  }

  @override
  void onEvent(DebugBlocEvent event) {
    super.onEvent(event);
    logDebug('DebugBloc -> onEvent(): ${event.runtimeType}');
  }
}
