import 'package:get_it/get_it.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/domain/services/license_service.dart';
import 'package:nfc_mobile_prototype/domain/usecases/update_index.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton(() => AppBloc(AppState(index: 0)));
  locator.registerLazySingleton(() => LicenseService());
  locator.registerLazySingleton(() => UpdateIndex(bloc: locator<AppBloc>()));
}
