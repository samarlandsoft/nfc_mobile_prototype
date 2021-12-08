import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc(AppBlocState initialState) : super(initialState);

  @override
  Stream<AppBlocState> mapEventToState(AppBlocEvent event) async* {
    logDebug('AppBloc -> mapEventToState(${event.runtimeType})');

    switch (event.runtimeType) {
      case AppUpdateWrapperCurtainMode:
        {
          var snapshot = event as AppUpdateWrapperCurtainMode;
          yield state.update(
            isTopCurtainEnabled: snapshot.isTopCurtainEnabled,
            isBottomCurtainEnabled: snapshot.isBottomCurtainEnabled,
          );
          break;
        }

      case AppUpdateNetworkConnectionMode:
        {
          var snapshot = event as AppUpdateNetworkConnectionMode;
          yield state.update(isNetworkEnabled: snapshot.isNetworkEnabled);
          break;
        }

      case AppPushScreen:
        {
          var snapshot = event as AppPushScreen;
          final List<int> updatedRoutes = [...state.routes];

          if (!updatedRoutes.contains(snapshot.screenIndex)) {
            updatedRoutes.add(snapshot.screenIndex);
          }

          yield state.update(routes: updatedRoutes);
          break;
        }

      case AppPopScreen:
        {
          var snapshot = event as AppPopScreen;
          final List<int> updatedRoutes = [...state.routes];

          if (updatedRoutes.length != 1) {
            updatedRoutes.removeLast();
          }

          yield state.update(routes: updatedRoutes);
          break;
        }
    }
  }
}
