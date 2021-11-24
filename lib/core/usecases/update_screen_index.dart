import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class UpdateScreenIndex implements Usecase<void, int> {
  final AppBloc bloc;

  const UpdateScreenIndex({required this.bloc});

  @override
  Future<void> call(int index) async {
    logDebug('UpdateScreenIndex usecase -> call($index)');
    if (bloc.state.currentScreenIndex == index) return;
    bloc.add(AppUpdateScreenIndex(index: index));
  }
}