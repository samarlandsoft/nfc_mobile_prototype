import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater_ownership.dart';

class UpdateMarketOwnerships
    implements Usecase<void, Map<CryptoCurrency, List<NFCSweaterOwnership>>> {
  final MarketBloc bloc;

  const UpdateMarketOwnerships({required this.bloc});

  @override
  Future<void> call(Map<CryptoCurrency, List<NFCSweaterOwnership>> ownerships) async {
    logDebug('UpdateMarketOwnerships usecase -> call(${ownerships.length})');
    if (bloc.state.ownerships == ownerships) return;
    bloc.add(MarketUpdateOwnerships(ownerships: ownerships));
  }
}
