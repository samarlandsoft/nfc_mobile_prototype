import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc(AppBlocState initialState) : super(initialState);

  @override
  Stream<AppBlocState> mapEventToState(AppBlocEvent event) async* {
    switch (event.runtimeType) {
      case AppUpdateScreenIndex:
        {
          var snapshot = event as AppUpdateScreenIndex;
          yield state.update(currentScreenIndex: snapshot.index);
          break;
        }

      case AppUpdateTheme:
        {
          var snapshot = event as AppUpdateTheme;
          yield state.update(isCustomTheme: snapshot.isCustomTheme);
          break;
        }

      case AppUpdateDebugMode:
        {
          var snapshot = event as AppUpdateDebugMode;
          yield state.update(isDebugEnabled: snapshot.isDebugEnabled);
          break;
        }

      case AppUpdateSplashMode:
        {
          var snapshot = event as AppUpdateSplashMode;
          yield state.update(isSplashPlayed: snapshot.isSplashPlayed);
          break;
        }
    }
  }
}
