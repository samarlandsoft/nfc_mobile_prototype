import 'package:nfc_mobile_prototype/domain/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/domain/models/usecase.dart';
import 'package:nfc_mobile_prototype/domain/services/logger.dart';

class UpdateIndex implements Usecase<void, int> {
  final AppBloc bloc;

  UpdateIndex({required this.bloc});

  @override
  Future<void> call(int index) async {
    logDebug('UpdateIndex usecase -> call()');
    bloc.add(AppUpdateIndex(index: index));
  }
}