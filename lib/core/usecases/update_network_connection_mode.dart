import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class UpdateNetworkConnectionMode implements Usecase<void, bool> {
  final AppBloc bloc;

  const UpdateNetworkConnectionMode({
    required this.bloc,
  });

  @override
  Future<void> call(bool isNetworkEnabled) async {
    logDebug('UpdateNetworkConnectionMode usecase -> call($isNetworkEnabled)');
    if (bloc.state.isNetworkEnabled == isNetworkEnabled) return;
    bloc.add(AppUpdateNetworkConnectionMode(isNetworkEnabled: isNetworkEnabled));
  }
}
