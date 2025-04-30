class AgroProduct {
  final int productId;
  final String name;
  final String category;
  final String description;
  final int price;
  final String unit;
  final int perUnitQuantity;
  final String imageUrl;

  AgroProduct({
    required this.productId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.unit,
    required this.perUnitQuantity,
    required this.imageUrl,
  });

  factory AgroProduct.fromJson(Map<String, dynamic> json) {
    return AgroProduct(
      productId: json['ProductID'],
      name: json['ProductName'],
      category: json['Category'],
      description: json['Description'],
      price: json['Price'],
      unit: json['Unit'],
      perUnitQuantity: json['PerUnitQuantity'],
      imageUrl: json['ImageURL'],
    );
  }
}
