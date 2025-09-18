import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductVariationModel {
  final String id;
  String sku;
  RxString image;
  String description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
     String image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributeValues,
  }) : image = image.obs;

  /// Empty variation (useful for default or fallbacks)
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'SoldQuantity': soldQuantity,
      'AttributeValues': attributeValues,
    };
  }

  /// Create model from JSON (e.g., Firebase document)
  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: json['Id'] ?? '',
      sku: json['SKU'] ?? '',
      image: json['Image'] ?? '',
      description: json['Description'] ?? '',
      price: (json['Price'] ?? 0.0).toDouble(),
      salePrice: (json['SalePrice'] ?? 0.0).toDouble(),
      stock: json['Stock'] ?? 0,
      soldQuantity: json['SoldQuantity'] ?? 0,
      attributeValues: Map<String, String>.from(json['AttributeValues'] ?? {}),
    );
  }
}
