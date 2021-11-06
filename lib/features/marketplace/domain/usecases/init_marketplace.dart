import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/blockchain_response_data.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/services/blockchain_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_mock_database.dart';

class InitMarketplace
    implements Usecase<BlockchainResponseData, CryptoCurrency> {
  final MarketBloc bloc;
  final BlockchainService blockchainService;

  const InitMarketplace({
    required this.bloc,
    required this.blockchainService,
  });

  @override
  Future<BlockchainResponseData> call(CryptoCurrency currency) async {
    logDebug('InitMarketplace usecase -> call($currency)');
    var currentPrice = await blockchainService.getCurrentPrice(currency);
    var amountSoldSweaters =
        blockchainService.getAmountSoldSweaters(currentPrice);
    var chipSrc = currency == CryptoCurrency.btc
        ? JWTMockDatabase.btcIDSweaterURLs[amountSoldSweaters + 1]
        : JWTMockDatabase.ethIDSweaterURLs[amountSoldSweaters + 1];

    List<NFCSweater> sweaters = bloc.state.sweaters.map((sweater) {
      if (sweater.currency == currency) {
        return sweater.update(
          chipSrc: chipSrc,
          price: double.parse(currentPrice.toStringAsFixed(2)),
          sold: amountSoldSweaters,
        );
      } else {
        return sweater;
      }
    }).toList();

    bloc.add(MarketUpdateSweaters(sweaters: sweaters));

    return BlockchainResponseData(
      price: currentPrice,
      sold: amountSoldSweaters,
    );
  }
}
