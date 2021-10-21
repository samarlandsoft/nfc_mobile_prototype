import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    switch (event.runtimeType) {
      case AppUpdateIndex: {
        var snapshot = event as AppUpdateIndex;
        yield state.update(index: snapshot.index);
        break;
      }

      case AppReadTag: {
        var snapshot = event as AppReadTag;
        yield state.update(tag: snapshot.tag);
        break;
      }
    }
  }
}