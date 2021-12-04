// import 'package:nfc_mobile_prototype/core/models/usecase.dart';
// import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
// import 'package:nfc_mobile_prototype/core/services/network_service.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_events.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/services/blockchain_service.dart';
//
// class GetBlockchainOwnerships implements Usecase<void, CryptoCurrency> {
//   final MarketBloc bloc;
//   final BlockchainService blockchainService;
//   final NetworkService networkService;
//
//   const GetBlockchainOwnerships({
//     required this.bloc,
//     required this.blockchainService,
//     required this.networkService,
//   });
//
//   @override
//   Future<void> call(CryptoCurrency currency) async {
//     logDebug('GetBlockchainOwnerships usecase -> call($currency)');
//     if (!await networkService.checkNetworkConnection()) return;
//
//     var memberships = await blockchainService.getHistory(currency);
//     bloc.add(MarketUpdateMemberships(memberships: memberships));
//   }
// }
