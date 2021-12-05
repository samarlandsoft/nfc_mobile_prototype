import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater_ownership.dart';

enum CryptoCurrency {
  none,
  btc,
  eth,
}

class NFCSweater {
  final int tokenID;
  final String title, edition, description;
  final CryptoCurrency currency;
  final List<NFCSweaterOwnership> ownership;
  final String? imageSrc, chipSrc, qrSrc;
  final double? price;
  final int? amount, sold;

  const NFCSweater({
    required this.tokenID,
    required this.title,
    required this.edition,
    required this.description,
    required this.currency,
    this.ownership = const [],
    this.imageSrc,
    this.chipSrc,
    this.qrSrc,
    this.price,
    this.amount,
    this.sold,
  });

  NFCSweater copyWith({
    int? tokenID,
    String? title,
    String? edition,
    String? description,
    CryptoCurrency? currency,
    List<NFCSweaterOwnership>? ownership,
    String? imageSrc,
    String? chipSrc,
    String? qrSrc,
    double? price,
    int? amount,
    int? sold,
  }) {
    return NFCSweater(
      tokenID: tokenID ?? this.tokenID,
      title: title ?? this.title,
      edition: edition ?? this.edition,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      ownership: ownership ?? this.ownership,
      imageSrc: imageSrc ?? this.imageSrc,
      chipSrc: chipSrc ?? this.chipSrc,
      qrSrc: qrSrc ?? this.qrSrc,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      sold: sold ?? this.sold,
    );
  }
}
