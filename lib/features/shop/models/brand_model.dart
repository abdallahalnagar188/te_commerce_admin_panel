
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String image;
  String name;
  int? productsCount;
  bool? isFeatured;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.productsCount,
    this.isFeatured,
  });

  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  Map<String, dynamic>toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
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
        productsCount: data['ProductsCount'] ?? ''
      );
    }else{
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
