import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';

class BlockchainNFCResponse {
  final int? tokenID;
  final CryptoCurrency currency;
  final String? chipSrc;
  final double? price;
  final int amount, sold;

  const BlockchainNFCResponse({
    required this.tokenID,
    required this.currency,
    required this.chipSrc,
    required this.price,
    required this.amount,
    required this.sold,
  });
}
