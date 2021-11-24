import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_state.dart';

class MarketBloc extends Bloc<MarketBlocEvent, MarketBlocState> {
  MarketBloc(MarketBlocState initialState) : super(initialState);

  @override
  Stream<MarketBlocState> mapEventToState(MarketBlocEvent event) async* {
    logDebug('MarketBloc -> mapEventToState(${event.runtimeType})');

    switch (event.runtimeType) {
      case MarketUpdateSweaters:
        {
          var snapshot = event as MarketUpdateSweaters;
          yield state.update(
            sweaters: snapshot.sweaters,
            isMarketSweatersInit: true,
          );
          break;
        }

      case MarketUpdateMemberships:
        {
          var snapshot = event as MarketUpdateMemberships;
          yield state.update(
            memberships: snapshot.memberships,
            isMarketMembershipsInit: true,
          );
          break;
        }
    }
  }
}
