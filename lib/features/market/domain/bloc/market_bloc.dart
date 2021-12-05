import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_state.dart';

class MarketBloc extends Bloc<MarketBlocEvent, MarketBlocState> {
  MarketBloc(MarketBlocState initialState) : super(initialState);

  @override
  Stream<MarketBlocState> mapEventToState(MarketBlocEvent event) async* {
    logDebug('MarketBloc -> mapEventToState(${event.runtimeType})');

    switch (event.runtimeType) {
      case MarketUpdateSweaters:
        {
          var snapshot = event as MarketUpdateSweaters;
          yield state.update(sweaters: snapshot.sweaters);
          break;
        }

      case MarketUpdateOwnerships:
        {
          var snapshot = event as MarketUpdateOwnerships;
          yield state.update(ownerships: snapshot.ownerships);
          break;
        }

      case MarketUpdateActiveSweater:
        {
          var snapshot = event as MarketUpdateActiveSweater;
          yield state.update(activeSweater: snapshot.activeSweater);
          break;
        }

      case MarketUpdateMode:
        {
          var snapshot = event as MarketUpdateMode;
          yield state.update(isMarketInit: snapshot.isInit);
          break;
        }
    }
  }
}
