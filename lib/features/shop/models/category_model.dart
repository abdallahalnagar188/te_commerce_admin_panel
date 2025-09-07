import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:te_commerce_admin_panel/utils/formatters/formatter.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = "",
    required this.isFeatured,
    this.createdAt,
    this.updatedAt
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeatured: false);

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  /// Convert model to json
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'CreatedAt' : createdAt,
      'UpdatedAt': updatedAt = DateTime.now()
    };
  }

  /// map json from firebase to UserModel

  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate():null,
        updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate():null,
      );
    }else{
      return CategoryModel.empty();
    }
  }
}
