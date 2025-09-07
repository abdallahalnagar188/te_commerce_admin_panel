import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class CategoryRepo extends GetxController {
  static CategoryRepo get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _dp = FirebaseFirestore.instance;

  // Get All Categories from Firebase
  Future<List<CategoryModel>> getAllCategories() async {
    try {

      final snapshot = await _dp.collection('Categories').get();
      final result = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Create Category
  Future<String> createCategory(CategoryModel category) async {
    try {
       final data = await _dp.collection('Categories').add(category.toJson());
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
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _dp.collection('Categories').doc(categoryId).delete();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
       await _dp.collection('Categories').doc(category.id).update(category.toJson());

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }



}
