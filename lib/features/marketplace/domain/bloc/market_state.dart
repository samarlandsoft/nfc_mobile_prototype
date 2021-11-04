import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';

class MarketBlocState {
  final List<NFCSweater> sweaters;

  const MarketBlocState({
    required this.sweaters,
  });

  factory MarketBlocState.initial() {
    return const MarketBlocState(
      sweaters: [
        NFCSweater(
          title: 'Season 1 Can\'t Be Stopped - Bitcoin Edition',
          edition: 'Bitcoin Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
          currency: CryptoCurrency.btc,
          imageSrc: 'assets/images/bitcoin_sweater.gif',
          chipSrc: 'assets/images/bitcoin_chip.gif',
          price: 6.05,
          priceStep: 0.28,
          amount: 20,
          sold: 16,
        ),
        NFCSweater(
          title: 'Season 1 Can\'t Be Stopped - Ethereum Edition',
          edition: 'Ethereum Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          tags: ['Genesis', 'NFT', 'ERC721', 'NFC'],
          currency: CryptoCurrency.eth,
          imageSrc: 'assets/images/ethereum_sweater.gif',
          chipSrc: 'assets/images/ethereum_chip.gif',
          price: 6.05,
          priceStep: 0.28,
          amount: 20,
          sold: 16,
        ),
      ],
    );
  }

  MarketBlocState update({
    List<NFCSweater>? sweaters,
  }) {
    return MarketBlocState(
      sweaters: sweaters ?? this.sweaters,
    );
  }
}
