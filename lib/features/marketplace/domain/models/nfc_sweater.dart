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
}
