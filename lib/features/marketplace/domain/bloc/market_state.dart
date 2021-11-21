import 'package:nfc_mobile_prototype/features/marketplace/domain/models/blockchain_memberships.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/services/blockchain_service.dart';

class MarketBlocState {
  final List<NFCSweater> sweaters;
  final List<BlockchainOwnerships> memberships;

  const MarketBlocState({
    required this.sweaters,
    this.memberships = const [],
  });

  factory MarketBlocState.initial() {
    return MarketBlocState(
      sweaters: [
        NFCSweater(
          tokenID: 0,
          title: 'Season 1 Can\'t Be Stopped - Bitcoin Edition',
          edition: 'Bitcoin Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
          currency: CryptoCurrency.btc,
          imageSrc: 'assets/images/bitcoin_sweater.gif',
          priceStep: double.parse(BlockchainService.priceStep.toStringAsFixed(2)),
          amount: 20,
        ),
        NFCSweater(
          tokenID: 0,
          title: 'Season 1 Can\'t Be Stopped - Ethereum Edition',
          edition: 'Ethereum Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
          currency: CryptoCurrency.eth,
          imageSrc: 'assets/images/ethereum_sweater.gif',
          priceStep: double.parse(BlockchainService.priceStep.toStringAsFixed(2)),
          amount: 20,
        ),
      ],
    );
  }

  MarketBlocState update({
    List<NFCSweater>? sweaters,
    List<BlockchainOwnerships>? memberships,
  }) {
    return MarketBlocState(
      sweaters: sweaters ?? this.sweaters,
      memberships: memberships ?? this.memberships,
    );
  }
}
