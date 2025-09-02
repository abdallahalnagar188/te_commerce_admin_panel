import 'dart:io' as io
    show File, SocketException; // alias for mobile/desktop File
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:universal_html/html.dart' as html; // alias for web File

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload Image (Web only - using bytes)
  Future<ImageModel> uploadImageFileInStorage({
    required Uint8List bytes,
    required String path,
    required String imageName,
  }) async {
    try {
      final Reference ref = _storage.ref('$path/$imageName');

      // Upload bytes instead of html.File
      await ref.putData(bytes);

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // Get metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
        metadata,
        path,
        imageName,
        downloadURL,
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    final data = await FirebaseFirestore.instance
        .collection('Images')
        .add(image.toJson());
    return data.id;
  }

  Future<List<ImageModel>> fetchImagesFromDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on io.SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ImageModel>> loadMoreImagesFromDatabase(
      MediaCategory mediaCategory,
      int loadCount,
      DateTime lastFetchDate) async
  {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .startAfter([lastFetchDate])
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on io.SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }


  Future<void> deleteFileFromStorage(ImageModel image) async {
    try {
      await   FirebaseStorage.instance.ref(image.fullPath).delete();
      await FirebaseFirestore.instance.collection('Images').doc(image.id).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on io.SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

}
