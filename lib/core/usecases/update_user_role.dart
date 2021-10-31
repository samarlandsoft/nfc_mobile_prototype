import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';

class UpdateUserRole implements Usecase<void, bool> {
  final AppBloc bloc;

  const UpdateUserRole({required this.bloc});

  @override
  Future<void> call(bool isAdmin) async {
    logDebug('UpdateUserRole usecase -> call()');
    bloc.add(AppUpdateUserRole(isUserAdmin: isAdmin));
  }
}