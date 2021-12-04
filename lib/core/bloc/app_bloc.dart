import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc(AppBlocState initialState) : super(initialState);

  @override
  Stream<AppBlocState> mapEventToState(AppBlocEvent event) async* {
    logDebug('AppBlocTemp -> mapEventToState(${event.runtimeType})');

    switch (event.runtimeType) {
      case AppUpdateScreenIndex:
        {
          var snapshot = event as AppUpdateScreenIndex;
          yield state.update(currentScreenIndex: snapshot.screenIndex);
          break;
        }

      case AppUpdateWrapperCurtainMode:
        {
          var snapshot = event as AppUpdateWrapperCurtainMode;
          yield state.update(
            isTopCurtainEnabled: snapshot.isTopCurtainEnabled,
            isBottomCurtainEnabled: snapshot.isBottomCurtainEnabled,
            isCurtainOpacityEnabled: snapshot.isCurtainOpacityEnabled,
          );
          break;
        }

      case AppUpdateNetworkConnectionMode:
        {
          var snapshot = event as AppUpdateNetworkConnectionMode;
          yield state.update(isNetworkEnabled: snapshot.isNetworkEnabled);
          break;
        }
    }
  }
}
