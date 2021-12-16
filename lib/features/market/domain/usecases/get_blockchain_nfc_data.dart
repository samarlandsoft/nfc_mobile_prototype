import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/services/network_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/datasources/blockchain_mock_database.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/services/blockchain_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_active_sweater.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/models/jwt_payload.dart';

class GetBlockchainNFCData implements Usecase<void, Map<String, dynamic>> {
  final MarketBloc bloc;
  final BlockchainService blockchainService;
  final NetworkService networkService;
  final UpdateMarketActiveSweater updateMarketActiveSweater;

  const GetBlockchainNFCData({
    required this.bloc,
    required this.blockchainService,
    required this.networkService,
    required this.updateMarketActiveSweater,
  });

  @override
  Future<void> call(Map<String, dynamic> tokenData) async {
    logDebug('GetBlockchainNFCData usecase -> call()');
    if (!await networkService.checkNetworkConnection()) {
      return;
    }

    final jwt = JWTPayloadModel.fromJson(tokenData);
    final tokenID = int.parse(jwt.tokenID);
    final currency = tokenID > 22 ? CryptoCurrency.btc : CryptoCurrency.eth;
    final chipUrl = BlockchainMockDatabase.sweaterTokenURLs[tokenID.toString()];
    final amountSoldSweaters = BlockchainMockDatabase.getAmountSoldSweaters(
        chipUrl!, currency == CryptoCurrency.btc);
    final price = blockchainService.getSweaterPrice(amountSoldSweaters - 1);

    updateMarketActiveSweater.call(NFCSweater(
      tokenID: tokenID,
      title: 'Season 1 Can\'t Be Stopped',
      edition: currency == CryptoCurrency.btc
          ? 'Bitcoin Edition'
          : 'Ethereum Edition',
      description:
          'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
      currency: currency,
      ownership: bloc.state.ownerships[currency] != null
          ? bloc.state.ownerships[currency]!
              .where((history) => history.tokenID.toInt() == tokenID)
              .toList()
          : [],
      chipSrc: chipUrl,
      qrSrc: 'assets/images/qr_code.png',
      price: price,
      amount: 20,
      sold: amountSoldSweaters,
    ));
  }
}
