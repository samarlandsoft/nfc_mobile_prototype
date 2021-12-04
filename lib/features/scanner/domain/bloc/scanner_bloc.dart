import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/scanner_evets.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/scanner_state.dart';

class ScannerBloc extends Bloc<ScannerBlocEvent, ScannerBlocState> {
  ScannerBloc(ScannerBlocState initialState) : super(initialState);

  @override
  Stream<ScannerBlocState> mapEventToState(ScannerBlocEvent event) async* {
    logDebug('ScannerBloc -> mapEventToState(${event.runtimeType})');

    switch (event.runtimeType) {
      case ScannerReadChipEvent: {
        var snapshot = event as ScannerReadChipEvent;
        yield state.update(token: snapshot.token);
        break;
      }
    }
  }
}