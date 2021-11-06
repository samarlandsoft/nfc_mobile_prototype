enum CryptoCurrency {
  none,
  btc,
  eth,
}

class NFCSweater {
  final String title, edition, description;
  final List<String> tags;
  final CryptoCurrency currency;
  final String? imageSrc, chipSrc;
  final double? price, priceStep;
  final int? amount, sold;

  const NFCSweater({
    required this.title,
    required this.edition,
    required this.description,
    required this.tags,
    required this.currency,
    this.imageSrc,
    this.chipSrc,
    this.price,
    this.priceStep,
    this.amount,
    this.sold,
  });

  NFCSweater update({
    String? title,
    String? edition,
    String? description,
    List<String>? tags,
    CryptoCurrency? currency,
    String? imageSrc,
    String? chipSrc,
    double? price,
    double? priceStep,
    int? amount,
    int? sold,
  }) {
    return NFCSweater(
      title: title ?? this.title,
      edition: edition ?? this.edition,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      currency: currency ?? this.currency,
      imageSrc: imageSrc ?? this.imageSrc,
      chipSrc: chipSrc ?? this.chipSrc,
      price: price ?? this.price,
      priceStep: priceStep ?? this.priceStep,
      amount: amount ?? this.amount,
      sold: sold ?? this.sold,
    );
  }
}
