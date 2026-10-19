class ProductItem {
  final String id;
  final String name;
  final String sku;
  final double price;
  final String category;
  final String? icon;

  const ProductItem({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.category,
    this.icon,
  });
}

