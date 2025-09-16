import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/categories_widget.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/platform_exceptions.dart';

import '../../../../features/shop/models/banner_model.dart';
import '../../../../features/shop/models/brand_category_model.dart';
import '../../../../features/shop/models/product_model.dart';

class ProductRepo extends GetxController {
  static ProductRepo get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get All Products from Firebase
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      final result = snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Create Product
  Future<String> createProduct(ProductModel product) async {
    try {
      final data = await _db.collection('Products').add(product.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Create Product Category
  Future<String> createProductCategory(ProductCategoryModel productCategory) async {
    try {
      final data = await _db.collection('ProductCategory').add(productCategory.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }


  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  Future<void> updateProductSpecificValue(String id,Map<String,dynamic> data) async {
    try {
      await _db.collection('Products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  Future<void> deleteProduct(ProductModel product) async{
    try {

      await _db.runTransaction((transaction) async {
        // Reference to the product
        final productRef = _db.collection("Products").doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception("Product not found");
        }

        // Fetch related ProductCategories
        final productCategoriesSnapshot = await _db
            .collection("ProductCategory")
            .where("productId", isEqualTo: product.id)
            .get();

        final productCategories = productCategoriesSnapshot.docs
            .map((e) => ProductCategoryModel.fromSnapshot(e))
            .toList();

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            final categoryRef =
            _db.collection("ProductCategory").doc(productCategory.categoryId);
            transaction.delete(categoryRef);
          }
        }

        // Finally delete the product itself
        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }
}
