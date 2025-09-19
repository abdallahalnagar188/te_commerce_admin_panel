import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:te_commerce_admin_panel/data/repos/auth/auth_repo.dart';
import 'package:te_commerce_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';

import '../../../features/auth/models/user_model.dart';
import '../../../features/shop/models/order_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _dp = FirebaseFirestore.instance;

  /// Function to save user to Firebase
  Future<void> createUser(UserModel user) async {
    try {
      await _dp.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  // fun to get all Users form firebase
  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _dp.collection('Users').orderBy('FirstName').get();
      final result = snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
      return result;
      } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  // fun to fetch user Order from firebase
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final snapshot = await _dp.collection('Users').doc(userId).collection('Orders').get();
      final result = snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
      return result;
    }
    on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }

  }

  // fun to update user details in firebase
  Future<void> updateUserDetails(UserModel user) async {
    try {
      await _dp.collection('Users').doc(user.id).update(user.toJson());
      } on FirebaseAuthException catch (e) {

      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }
// fun to delete user from firebase
  Future<void> deleteUser(String userId) async {
    try {
      await _dp.collection('Users').doc(userId).delete();
      } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }}

  Future<UserModel> fetchAdminDetails() async {
    try {
      final docSnapshot = await _dp.collection('Users').doc(AuthRepo.instance.authUser!.uid).get();
      if (docSnapshot.exists) {
        return UserModel.fromSnapshot(docSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  Future fetchUserDetails(String userId) async {
    try {
      final docSnapshot = await _dp.collection('Users').doc(userId).get();
      if (docSnapshot.exists) {
        return UserModel.fromSnapshot(docSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }
}
