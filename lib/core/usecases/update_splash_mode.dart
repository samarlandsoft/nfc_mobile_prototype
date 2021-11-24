import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class UpdateSplashMode implements Usecase<void, bool> {
  final AppBloc bloc;

  const UpdateSplashMode({
    required this.bloc,
  });

  @override
  Future<void> call(bool isSplashPlayed) async {
    logDebug('UpdateSplashMode usecase -> call($isSplashPlayed)');
    if (bloc.state.isSplashPlayed == isSplashPlayed) return;
    bloc.add(AppUpdateSplashMode(isSplashPlayed: isSplashPlayed));
  }
}
