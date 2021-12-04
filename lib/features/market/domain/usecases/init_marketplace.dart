// import 'package:nfc_mobile_prototype/core/models/usecase.dart';
// import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/get_blockchain_memberships.dart';
// import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/get_blockchain_prices.dart';
//
// class InitMarketplace implements Usecase<void, NoParams> {
//   final MarketBloc bloc;
//   final GetBlockchainPrices getBlockchainData;
//   final GetBlockchainOwnerships getBlockchainOwnerships;
//
//   const InitMarketplace({
//     required this.bloc,
//     required this.getBlockchainData,
//     required this.getBlockchainOwnerships,
//   });
//
//   @override
//   Future<void> call(NoParams params) async {
//     logDebug('InitMarketplace usecase -> call()');
//     for (var currency in CryptoCurrency.values
//         .where((currency) => currency != CryptoCurrency.none)) {
//       getBlockchainData.call(currency);
//       getBlockchainOwnerships.call(currency);
//     }
//   }
// }
