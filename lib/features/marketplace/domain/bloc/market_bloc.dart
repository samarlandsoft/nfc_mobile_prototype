import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_events.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_state.dart';

class MarketBloc extends Bloc<MarketBlocEvent, MarketBlocState> {
  MarketBloc(MarketBlocState initialState) : super(initialState);

  @override
  Stream<MarketBlocState> mapEventToState(MarketBlocEvent event) async* {
    switch (event.runtimeType) {
      case MarketUpdateSweaters:
        {
          var snapshot = event as MarketUpdateSweaters;
          yield state.update(sweaters: snapshot.sweaters);
          break;
        }
    }
  }
}
