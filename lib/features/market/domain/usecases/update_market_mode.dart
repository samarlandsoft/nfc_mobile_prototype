import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_events.dart';

class UpdateMarketMode implements Usecase<void, bool> {
  final MarketBloc bloc;

  const UpdateMarketMode({required this.bloc});

  @override
  Future<void> call(bool isInit) async {
    logDebug('UpdateMarketMode usecase -> call($isInit)');
    if (bloc.state.isMarketInit == isInit) return;
    bloc.add(MarketUpdateMode(isInit: isInit));
  }
}