import 'package:get_it/get_it.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/services/license_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc_state.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/read_nfc_data.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/write_nfc_data.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  _initCore();
  _initNFCScanner();
}

void _initCore() {
  locator.registerLazySingleton(() => AppBloc(AppBlocState()));
  locator.registerLazySingleton(() => LicenseService());
  locator.registerLazySingleton(() => UpdateScreenIndex(bloc: locator<AppBloc>()));
}

void _initNFCScanner() {
  locator.registerLazySingleton(() => NFCBloc(NFCBlocState()));
  locator.registerLazySingleton(() => NFCService());
  locator.registerLazySingleton(() => ReadNFCData(
        bloc: locator<NFCBloc>(),
        nfcService: locator<NFCService>(),
      ));
  locator.registerLazySingleton(() => WriteNFCData(
        bloc: locator<NFCBloc>(),
        nfcService: locator<NFCService>(),
      ));
}
