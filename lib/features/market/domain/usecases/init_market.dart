import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/services/network_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater_ownership.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/get_blockchain_ownership.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/get_blockchain_available_prices.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_mode.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_ownerships.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_sweaters.dart';

class InitMarket implements Usecase<void, NoParams> {
  final MarketBloc bloc;
  final NetworkService networkService;

  final GetBlockchainAvailablePrices getBlockchainPrices;
  final GetBlockchainOwnership getBlockchainOwnership;

  final UpdateMarketSweaters updateMarketSweaters;
  final UpdateMarketOwnerships updateMarketOwnerships;
  final UpdateMarketMode updateMarketMode;

  const InitMarket({
    required this.bloc,
    required this.networkService,
    required this.getBlockchainPrices,
    required this.getBlockchainOwnership,
    required this.updateMarketSweaters,
    required this.updateMarketOwnerships,
    required this.updateMarketMode,
  });

  @override
  Future<void> call(NoParams params) async {
    logDebug('InitMarket usecase -> call()');
    if (!await networkService.checkNetworkConnection()) {
      return;
    }

    final List<NFCSweater> sweaters = [];
    final Map<CryptoCurrency, List<NFCSweaterOwnership>> ownerships = {};

    for (var currency in CryptoCurrency.values
        .where((currency) => currency != CryptoCurrency.none)) {
      final data = await getBlockchainPrices.call(currency, isMarketInit: true);
      final ownershipHistory = await getBlockchainOwnership.call(currency);

      if (data == null && ownershipHistory == null) {
        return;
      }

      final NFCSweater updatedSweater =
          bloc.state.sweaters.firstWhere((sweater) {
        return sweater.currency == currency;
      });

      sweaters.add(updatedSweater.copyWith(
        tokenID: data!.tokenID,
        chipSrc: data.chipSrc,
        price: data.price,
        amount: data.amount,
        sold: data.sold,
        ownership: ownershipHistory!
            .where((history) => history.tokenID.toInt() == data.tokenID)
            .toList(),
      ));

      ownerships.putIfAbsent(currency, () => ownershipHistory);
    }

    if (sweaters.isNotEmpty) {
      updateMarketSweaters.call(sweaters);
      updateMarketOwnerships.call(ownerships);
      updateMarketMode.call(true);
    }
  }
}
