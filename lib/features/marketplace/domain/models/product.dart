class Product {
  final String title, edition, description;
  final List<String> tags;
  final String imageSrc;
  final double price, priceStep;
  final int amount, sold;

  const Product({
    required this.title,
    required this.edition,
    required this.description,
    required this.tags,
    required this.imageSrc,
    required this.price,
    required this.priceStep,
    required this.amount,
    required this.sold,
  });
}
