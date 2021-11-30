import 'package:get_it/get_it.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/services/firebase_service.dart';
import 'package:nfc_mobile_prototype/core/services/license_service.dart';
import 'package:nfc_mobile_prototype/core/services/local_storage_service.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/services/network_service.dart';
import 'package:nfc_mobile_prototype/core/services/web_view_service.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_debug_mode.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_network_connection_mode.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_splash_mode.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_theme_mode.dart';
import 'package:nfc_mobile_prototype/core/usecases/upload_logs.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/services/blockchain_service.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/get_blockchain_memberships.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/get_blockchain_prices.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/init_marketplace.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_state.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_mock_database.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/read_nfc_data.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/show_nfc_data.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/usecases/write_nfc_data.dart';

final locator = GetIt.instance;

void initLocator() {
  _initCore();
  _initMarketplace();
  _initNFCScanner();
}

void _initCore() {
  /// Blocs
  locator.registerLazySingleton(() => AppBloc(AppBlocState.initial()));

  /// Services
  locator.registerLazySingleton(() => LicenseService());
  locator.registerLazySingleton(() => LoggerService());
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerLazySingleton(() => LocalStorageService());
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
  locator.registerLazySingleton(() => UpdateThemeMode(
        bloc: locator<AppBloc>(),
        storageService: locator<LocalStorageService>(),
      ));
  locator.registerLazySingleton(() => UpdateDebugMode(
        bloc: locator<AppBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateNetworkConnectionMode(
        bloc: locator<AppBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateSplashMode(
        bloc: locator<AppBloc>(),
      ));
  locator.registerLazySingleton(() => UploadLogs(
        loggerService: locator<LoggerService>(),
        firebaseService: locator<FirebaseService>(),
      ));
}

void _initNFCScanner() {
  /// Blocs
  locator.registerLazySingleton(() => NFCBloc(const NFCBlocState()));

  /// Services
  locator.registerLazySingleton(() => NFCService(
        jwtService: locator<JWTService>(),
      ));
  locator.registerLazySingleton(() => JWTService());
  locator.registerLazySingleton(() => JWTMockDatabase());

  /// Usecases
  locator.registerLazySingleton(() => ShowNFCData(
        bloc: locator<NFCBloc>(),
        nfcService: locator<NFCService>(),
        jwtService: locator<JWTService>(),
      ));
  locator.registerLazySingleton(() => ReadNFCData(
        bloc: locator<NFCBloc>(),
        nfcService: locator<NFCService>(),
        jwtService: locator<JWTService>(),
      ));
  locator.registerLazySingleton(() => WriteNFCData(
        bloc: locator<NFCBloc>(),
        nfcService: locator<NFCService>(),
      ));
}

void _initMarketplace() {
  /// Blocs
  locator.registerLazySingleton(() => MarketBloc(MarketBlocState.initial()));

  /// Services
  locator.registerLazySingleton(() => BlockchainService());

  /// Usecases
  locator.registerLazySingleton(() => InitMarketplace(
        bloc: locator<MarketBloc>(),
        getBlockchainData: locator<GetBlockchainPrices>(),
        getBlockchainOwnerships: locator<GetBlockchainOwnerships>(),
      ));
  locator.registerLazySingleton(() => GetBlockchainPrices(
        bloc: locator<MarketBloc>(),
        blockchainService: locator<BlockchainService>(),
        networkService: locator<NetworkService>(),
      ));
  locator.registerLazySingleton(() => GetBlockchainOwnerships(
        bloc: locator<MarketBloc>(),
        blockchainService: locator<BlockchainService>(),
        networkService: locator<NetworkService>(),
      ));
}
