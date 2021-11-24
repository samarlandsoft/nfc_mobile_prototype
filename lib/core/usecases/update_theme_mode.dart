import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/local_storage_service.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class UpdateThemeMode implements Usecase<void, bool?> {
  final AppBloc bloc;
  final LocalStorageService storageService;

  const UpdateThemeMode({
    required this.bloc,
    required this.storageService,
  });

  @override
  Future<void> call(bool? isCustomTheme,
      {bool updateLocalStorage = true}) async {
    logDebug('UpdateThemeMode usecase -> call($isCustomTheme, $updateLocalStorage)');
    var isCustomThemeActive = !bloc.state.isCustomTheme;
    bloc.add(AppUpdateTheme(isCustomTheme: isCustomTheme ?? isCustomThemeActive));
    if (updateLocalStorage) {
      storageService.updateAppTheme(isCustomTheme ?? isCustomThemeActive);
    }
  }
}
