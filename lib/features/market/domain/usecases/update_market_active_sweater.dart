import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';

class UpdateMarketActiveSweater implements Usecase<void, NFCSweater?> {
  final MarketBloc bloc;

  const UpdateMarketActiveSweater({required this.bloc});

  @override
  Future<void> call(NFCSweater? sweater) async {
    logDebug('UpdateMarketActiveSweater usecase -> call(${sweater?.tokenID})');
    if (bloc.state.activeSweater == sweater) return;
    bloc.add(MarketUpdateActiveSweater(activeSweater: sweater));
  }
}
