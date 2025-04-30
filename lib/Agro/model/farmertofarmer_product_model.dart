class FarmertoFarmerProduct {
  final int productId;
  final String productName;
  final String category;
  final String description;
  final int price;
  final int stockQuantity;
  final String unit;
  final int perUnitQuantity;
  final String imageUrl;
  final String? productVideo;
  final String? profileImage;
  // final String name;
  // final String mobile;
  // final String city;

  FarmertoFarmerProduct({
    required this.productId,
    required this.productName,
    required this.category,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.unit,
    required this.perUnitQuantity,
    required this.imageUrl,
    // required this.name,
    // required this.mobile,
    // required this.city,
    this.productVideo,
    this.profileImage,
  });

  factory FarmertoFarmerProduct.fromJson(Map<String, dynamic> json) {
    return FarmertoFarmerProduct(
      productId: json['ProductID'],
      productName: json['ProductName'],
      category: json['Category'],
      description: json['Description'],
      price: json['Price'],
      stockQuantity: json['StockQuantity'],
      unit: json['Unit'],
      perUnitQuantity: json['PerUnitQuantity'],
      imageUrl: json['ImageURL'],
      productVideo: json['productVideo'] ?? '',
      profileImage: json['profileImage'] ?? '',
      // name: json['name'],
      // mobile: json['mobile'],
      // city: json['city'],
    );
  }
}
