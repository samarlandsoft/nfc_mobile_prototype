import 'package:nfc_mobile_prototype/features/marketplace/domain/models/blockchain_memberships.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';

abstract class MarketBlocEvent {
  const MarketBlocEvent([List props = const []]) : super();
}

class MarketUpdateSweaters extends MarketBlocEvent {
  final List<NFCSweater> sweaters;

  MarketUpdateSweaters({required this.sweaters}) : super([sweaters]);
}

class MarketUpdateMemberships extends MarketBlocEvent {
  final List<BlockchainOwnerships> memberships;

  MarketUpdateMemberships({required this.memberships})
      : super([memberships]);
}
