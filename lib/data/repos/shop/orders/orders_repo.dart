import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/order_model.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class OrderRepo extends GetxController {
  static OrderRepo get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _dp = FirebaseFirestore.instance;

  // Get All Orders from Firebase
  Future<List<OrderModel>> getAllOrders() async {
    try {

      final snapshot = await _dp.collection('Orders').orderBy('orderDate', descending: true).get();
      final result = snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // store a new user order
  Future<void> addOrder(OrderModel order) async {
    try {
      await _dp.collection('Orders').add(order.toJson());

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  // Update a specific value of an order instance
  Future<void> updateOrderSpecificValue(String orderId,Map<String, dynamic> data ) async {
    try {

      await _dp.collection('Orders').doc(orderId).update(data);

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
    }

  // Delete Order from firebase
  Future<void> deleteOrder(String orderId) async {
    try {
      await _dp.collection('Orders').doc(orderId).delete();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

}
