import 'package:get_it/get_it.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/domain/services/license_service.dart';
import 'package:nfc_mobile_prototype/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/domain/usecases/read_nfc_tag.dart';
import 'package:nfc_mobile_prototype/domain/usecases/update_index.dart';
import 'package:nfc_mobile_prototype/domain/usecases/write_nfc_tag.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton(() => AppBloc(AppState(index: 0)));
  locator.registerLazySingleton(() => LicenseService());
  locator.registerLazySingleton(() => NFCService());
  locator.registerLazySingleton(() => UpdateIndex(bloc: locator<AppBloc>()));
  locator.registerLazySingleton(() => ReadNFCTag(
        bloc: locator<AppBloc>(),
        nfcService: locator<NFCService>(),
      ));
  locator.registerLazySingleton(() => WriteNFCTag(
        bloc: locator<AppBloc>(),
        nfcService: locator<NFCService>(),
      ));
}
