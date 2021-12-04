import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';

class MarketBlocState {
  final List<NFCSweater> sweaters;
  final NFCSweater? activeSweater;
  final bool isMarketInit;

  const MarketBlocState({
    required this.sweaters,
    this.activeSweater,
    this.isMarketInit = false,
  });

  factory MarketBlocState.initial() {
    return const MarketBlocState(
      sweaters: [
        NFCSweater(
          tokenID: 0,
          title: 'Season 1 Can\'t Be Stopped',
          edition: 'Bitcoin Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          currency: CryptoCurrency.btc,
          imageSrc: 'assets/images/bitcoin_sweater.gif',
          chipSrc: 'assets/images/bitcoin_chip.gif',
          qrSrc: 'assets/images/qr_code.png',
          price: 6.05,
          amount: 20,
          sold: 17,
        ),
        NFCSweater(
          tokenID: 0,
          title: 'Season 1 Can\'t Be Stopped',
          edition: 'Ethereum Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          currency: CryptoCurrency.eth,
          imageSrc: 'assets/images/ethereum_sweater.gif',
          chipSrc: 'assets/images/ethereum_chip.gif',
          qrSrc: 'assets/images/qr_code.png',
          price: 6.05,
          amount: 20,
          sold: 17,
        ),
      ],
      isMarketInit: false,
    );
  }

  MarketBlocState update({
    List<NFCSweater>? sweaters,
    NFCSweater? activeSweater,
    bool? isMarketInit,
  }) {
    return MarketBlocState(
      sweaters: sweaters ?? this.sweaters,
      activeSweater: activeSweater ?? this.activeSweater,
      isMarketInit: isMarketInit ?? this.isMarketInit,
    );
  }
}
