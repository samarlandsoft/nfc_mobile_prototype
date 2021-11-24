import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class UpdateDebugMode implements Usecase<void, bool> {
  final AppBloc bloc;

  const UpdateDebugMode({
    required this.bloc,
  });

  @override
  Future<void> call(bool isDebugEnabled) async {
    logDebug('UpdateDebugMode usecase -> call($isDebugEnabled)');
    if (bloc.state.isDebugEnabled == isDebugEnabled) return;
    bloc.add(AppUpdateDebugMode(isDebugEnabled: isDebugEnabled));
  }
}
