import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/services/network_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/datasources/blockchain_mock_database.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/blockchain_nfc_response.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/services/blockchain_service.dart';

class GetBlockchainAvailablePrices implements Usecase<BlockchainNFCResponse?, CryptoCurrency> {
  final BlockchainService blockchainService;
  final NetworkService networkService;

  const GetBlockchainAvailablePrices({
    required this.blockchainService,
    required this.networkService,
  });

  @override
  Future<BlockchainNFCResponse?> call(CryptoCurrency currency, {bool isMarketInit = false}) async {
    logDebug('GetBlockchainPrices usecase -> call($currency, $isMarketInit)');
    if (!await networkService.checkNetworkConnection()) {
      return null;
    }

    final currentPrice = await blockchainService.getCurrentPrice(currency);
    final amountSoldSweaters =
        blockchainService.getAmountSoldSweaters(currentPrice);
    final tokenID = isMarketInit ? amountSoldSweaters + 1 : amountSoldSweaters;
    final chipSrc = currency == CryptoCurrency.btc
        ? BlockchainMockDatabase.btcIDSweaterURLs[tokenID]
        : BlockchainMockDatabase.ethIDSweaterURLs[tokenID];
    final bool isEnableToBuy = tokenID < 20;

    return BlockchainNFCResponse(
      tokenID: isEnableToBuy ? tokenID : null,
      currency: currency,
      chipSrc: chipSrc,
      price: isEnableToBuy ? double.parse(currentPrice.toStringAsFixed(2)) : null,
      amount: 20,
      sold: isMarketInit ? tokenID : amountSoldSweaters,
    );
  }
}
