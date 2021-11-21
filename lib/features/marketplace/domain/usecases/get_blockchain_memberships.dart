import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/services/blockchain_service.dart';

class GetBlockchainMemberships implements Usecase<void, CryptoCurrency> {
  final MarketBloc bloc;
  final BlockchainService blockchainService;

  const GetBlockchainMemberships({
    required this.bloc,
    required this.blockchainService,
  });

  @override
  Future<void> call(CryptoCurrency currency) async {
    logDebug('GetBlockchainMemberships usecase -> call($currency)');
    var memberships = await blockchainService.getHistory(currency);
    bloc.add(MarketUpdateMemberships(memberships: memberships));
  }
}
