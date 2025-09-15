import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/platform_exceptions.dart';

import '../../../../features/shop/models/banner_model.dart';
import '../../../../features/shop/models/brand_category_model.dart';

class BannersRepo extends GetxController {
  static BannersRepo get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _dp = FirebaseFirestore.instance;

  // Get All Banners from Firebase
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _dp.collection('Banners').get();
      final result =
          snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Create Banner
  Future<String> createBanner(BannerModel banner) async {
    try {
      final data = await _dp.collection('Banners').add(banner.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }



  Future<void> updateBrand(BannerModel banner) async {
    try {
      await _dp.collection('Banners').doc(banner.id).update(banner.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  Future<void> deleteBanner(String bannerId) async{
    try {
      _dp.collection('Banners').doc(bannerId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }
}
