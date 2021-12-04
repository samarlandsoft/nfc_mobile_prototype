import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';

class UpdateMarketSweaters implements Usecase<void, List<NFCSweater>> {
  final MarketBloc bloc;

  const UpdateMarketSweaters({required this.bloc});

  @override
  Future<void> call(List<NFCSweater> sweaters) async {
    logDebug('UpdateMarketSweaters usecase -> call(${sweaters.length})');
    if (bloc.state.sweaters == sweaters) return;
    bloc.add(MarketUpdateSweaters(sweaters: sweaters));
  }
}