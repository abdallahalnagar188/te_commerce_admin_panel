import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../features/personalization/models/settings_model.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';

/// Repository class for setting-related operations.
class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save setting data to Firestore.
  Future<void> registerSettings(SettingModel setting) async {
    try {
      await _db
          .collection("Settings")
          .doc('GLOBAL_SETTINGS')
          .set(setting.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch setting details based on setting ID.
  Future<SettingModel> getSettings() async {
    try {
      final querySnapshot =
          await _db.collection("Settings").doc('GLOBAL_SETTINGS').get();
      return SettingModel.fromSnapshot(querySnapshot);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// fun to update sitting data in firebase
  Future<void> updateSettings(SettingModel setting) async {
    try {
      await _db
          .collection("Settings")
          .doc('GLOBAL_SETTINGS')
          .update(setting.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// fun to update any field in specific settings collection
Future<void> updateSettingField(Map<String, dynamic> data) async {
    try {
      await _db
          .collection("Settings")
          .doc('GLOBAL_SETTINGS')
          .update(data);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
}
}
