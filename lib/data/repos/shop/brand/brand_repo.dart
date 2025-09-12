import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/platform_exceptions.dart';

import '../../../../features/shop/models/brand_category_model.dart';

class BrandRepo extends GetxController {
  static BrandRepo get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _dp = FirebaseFirestore.instance;

  // Get All Brands from Firebase
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _dp.collection('Brands').get();
      final result =
          snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Get All Brands from Firebase
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final snapshot = await _dp.collection('BrandCategories').get();
      final result = snapshot.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // get Specific brand category for a given brand Id
  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(
      String brandId) async {
    try {
      final brandCategoryQuery = await _dp
          .collection('BrandCategory')
          .where('brandId', isEqualTo: brandId)
          .get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Create Category
  Future<String> createBrand(BrandModel brand) async {
    try {
      final data = await _dp.collection('Brands').add(brand.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Create Brand Category
  Future<String> createBrandCategory(BrandCategoryModel brandCategory) async {
    try {
      final data =
          await _dp.collection('BrandCategories').add(brandCategory.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Delete category from firebase
  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _dp.runTransaction((transaction) async {
        final brandRef = _dp.collection('Brands').doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception('Brand not Found');
        }
        final brandCategoriesSnapshot = await _dp
            .collection('BrandCategory')
            .where('brandId', isEqualTo: brand.id)
            .get();
        final brandCategories = brandCategoriesSnapshot.docs
            .map((e) => BrandCategoryModel.fromSnapshot(e));

        if (brandCategories.isNotEmpty) {
          for (var brandCategory in brandCategories) {
            transaction
                .delete(_dp.collection('BrandCategory').doc(brandCategory.id));
          }
        }
        transaction.delete(brandRef);
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }


  Future<void> deleteBrandCategory(String brandCategoryId) async {
    try {
      await _dp.collection('BrandCategory').doc(brandCategoryId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _dp.collection('Brands').doc(brand.id).update(brand.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }
}
