import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';

import '../../../utils/formatters/formatter.dart';

class BrandModel {
  String id;
  String image;
  String name;
  int? productsCount;
  bool? isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Not mapped
  List<CategoryModel>? brandCategories;

  BrandModel(
      {required this.id,
      required this.image,
      required this.name,
      this.productsCount,
      this.isFeatured,
      this.createdAt,
      this.updatedAt,
      this.brandCategories});

  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now()
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductsCount'],
      isFeatured: data['IsFeatured'],
    );
  }

  /// map json from firebase to UserModel

  factory BrandModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductsCount'] ?? '',
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return BrandModel.empty();
    }
  }

  BrandModel copyWith({
    String? id,
    String? image,
    String? name,
    int? productsCount,
    bool? isFeatured,
  }) {
    return BrandModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      productsCount: productsCount ?? this.productsCount,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  @override
  String toString() {
    return 'BrandModel(id: $id, name: $name, image: $image, '
        'productsCount: $productsCount, isFeatured: $isFeatured)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          image == other.image &&
          name == other.name &&
          productsCount == other.productsCount &&
          isFeatured == other.isFeatured;

  @override
  int get hashCode =>
      id.hashCode ^
      image.hashCode ^
      name.hashCode ^
      productsCount.hashCode ^
      isFeatured.hashCode;
}
