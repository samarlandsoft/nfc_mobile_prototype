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
  Future<BlockchainNFCResponse?> call(CryptoCurrency currency) async {
    logDebug('GetBlockchainPrices usecase -> call($currency)');
    if (!await networkService.checkNetworkConnection()) {
      return null;
    }

    final currentPrice = await blockchainService.getCurrentPrice(currency);
    final amountSoldSweaters =
        blockchainService.getAmountSoldSweaters(currentPrice);
    final tokenID = amountSoldSweaters;
    final chipSrc = currency == CryptoCurrency.btc
        ? BlockchainMockDatabase.btcIDSweaterURLs[tokenID]
        : BlockchainMockDatabase.ethIDSweaterURLs[tokenID];

    return BlockchainNFCResponse(
      tokenID: tokenID,
      currency: currency,
      chipSrc: chipSrc!,
      price: double.parse(currentPrice.toStringAsFixed(2)),
      amount: 20,
      sold: amountSoldSweaters,
    );
  }
}
