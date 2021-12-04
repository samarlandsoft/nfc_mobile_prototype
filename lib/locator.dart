import 'package:get_it/get_it.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/services/firebase_service.dart';
import 'package:nfc_mobile_prototype/core/services/license_service.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/services/network_service.dart';
import 'package:nfc_mobile_prototype/core/services/web_view_service.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_network_connection_mode.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_active_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_mode.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_sweaters.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/scanner_bloc.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/scanner_state.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/datasources/jwt_mock_database.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/services/jwt_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/usecases/read_nfc_chip.dart';

final locator = GetIt.instance;

void initLocator() {
  _initCore();
  _initScanner();
  _initMarket();
}

void _initCore() {
  /// Blocs
  locator.registerLazySingleton(() => AppBloc(AppBlocState.initial()));

  /// Services
  locator.registerLazySingleton(() => LoggerService());

  locator.registerLazySingleton(() => LicenseService());
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerLazySingleton(() => WebViewService(
        networkService: locator<NetworkService>(),
      ));
  locator.registerLazySingleton(() => NetworkService(
        updateNetworkConnectionMode: locator<UpdateNetworkConnectionMode>(),
      ));

  /// Usecases
  locator.registerLazySingleton(() => UpdateScreenIndex(
        bloc: locator<AppBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateWrapperCurtainMode(
        bloc: locator<AppBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateNetworkConnectionMode(
        bloc: locator<AppBloc>(),
      ));
}

void _initScanner() {
  /// Blocs
  locator.registerLazySingleton(() => ScannerBloc(const ScannerBlocState()));

  /// Services
  locator.registerLazySingleton(
      () => NFCService(jwtService: locator<JWTService>()));
  locator.registerLazySingleton(() => JWTService());

  /// Datasources
  locator.registerLazySingleton(() => JWTMockDatabaseTemp());

  /// Usecases
  locator.registerLazySingleton(() => ReadNFCChip(
        bloc: locator<ScannerBloc>(),
        nfcService: locator<NFCService>(),
        jwtService: locator<JWTService>(),
      ));
}

void _initMarket() {
  /// Blocs
  locator.registerLazySingleton(() => MarketBloc(MarketBlocState.initial()));

  /// Services

  /// Usecases
  locator.registerLazySingleton(() => UpdateMarketSweaters(
        bloc: locator<MarketBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateMarketActiveSweater(
        bloc: locator<MarketBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateMarketMode(
        bloc: locator<MarketBloc>(),
      ));
}
