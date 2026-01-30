import 'dart:io' as io show SocketException; // alias for mobile/desktop File
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/supabase_config.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  /// Get Supabase client instance
  SupabaseClient get _supabase => Supabase.instance.client;

  /// Ensure the storage bucket exists, or try to use an available bucket
  Future<String> _ensureBucketExists() async {
    // Try to list buckets to see what's available (might fail with anon key)
    try {
      final buckets = await _supabase.storage.listBuckets();

      debugPrint('Available buckets: ${buckets.map((b) => b.name).toList()}');
      debugPrint('Looking for bucket: "${SupabaseConfig.storageBucket}"');

      // Check if our configured bucket exists (case-insensitive check)
      final bucketExists = buckets.any((bucket) =>
          bucket.name.toLowerCase() ==
          SupabaseConfig.storageBucket.toLowerCase());

      if (bucketExists) {
        // Find the exact bucket name (case-sensitive)
        final exactBucket = buckets.firstWhere((bucket) =>
            bucket.name.toLowerCase() ==
            SupabaseConfig.storageBucket.toLowerCase());
        debugPrint('Found bucket: "${exactBucket.name}"');
        return exactBucket.name;
      }

      // If configured bucket doesn't exist, try to use the first available bucket
      if (buckets.isNotEmpty) {
        final firstBucket = buckets.first.name;
        debugPrint(
            'Warning: Bucket "${SupabaseConfig.storageBucket}" not found. Using "${firstBucket}" instead.');
        return firstBucket;
      }

      // No buckets found
      throw Exception('No storage buckets found in your Supabase project.\n\n'
          'Please create a storage bucket:\n'
          '1. Go to https://supabase.com/dashboard\n'
          '2. Select your project\n'
          '3. Navigate to Storage > New bucket\n'
          '4. Create a bucket (name it: "${SupabaseConfig.storageBucket}" or any name)\n'
          '5. Set it as PUBLIC\n'
          '6. Update storageBucket in supabase_config.dart to match your bucket name');
    } catch (e) {
      // Listing buckets might fail with anon key - that's okay
      debugPrint(
          'Could not list buckets (this is normal with anon key). Trying configured bucket: "${SupabaseConfig.storageBucket}"');

      // We'll try the configured bucket, and if it fails, the error handler will show available options
      return SupabaseConfig.storageBucket;
    }
  }

  /// Upload Image (Web only - using bytes)
  Future<ImageModel> uploadImageFileInStorage({
    required Uint8List bytes,
    required String path,
    required String imageName,
  }) async {
    try {
      // Ensure bucket exists or get an available bucket
      final bucketName = await _ensureBucketExists();

      // Construct the full path for Supabase storage
      // Ensure path doesn't start with / to avoid double slashes in URL
      final cleanPath = path.startsWith('/') ? path.substring(1) : path;
      final String filePath = '$cleanPath/$imageName';

      // Determine content type based on file extension
      String contentType = 'image/jpeg';
      if (imageName.toLowerCase().endsWith('.png')) {
        contentType = 'image/png';
      } else if (imageName.toLowerCase().endsWith('.gif')) {
        contentType = 'image/gif';
      } else if (imageName.toLowerCase().endsWith('.webp')) {
        contentType = 'image/webp';
      }

      // Upload bytes to Supabase storage
      await _supabase.storage.from(bucketName).uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              upsert: true,
              contentType: contentType,
            ),
          );

      // Get public URL
      final String downloadURL =
          _supabase.storage.from(bucketName).getPublicUrl(filePath);

      // Create ImageModel with upload information
      return ImageModel.fromSupabaseUpload(
        downloadUrl: downloadURL,
        folder: path,
        fileName: imageName,
        fullPath: filePath,
        sizeBytes: bytes.length,
        contentType: contentType,
      );
    } on StorageException catch (e) {
      debugPrint('Supabase Storage Exception: ${e.message}');
      debugPrint('Error Status Code: ${e.statusCode}');

      // Handle Supabase StorageException specifically
      if (e.message.contains('Bucket not found') || e.statusCode == 404) {
        // Try to list available buckets to help user
        String availableBucketsInfo = '';
        try {
          final buckets = await _supabase.storage.listBuckets();
          if (buckets.isNotEmpty) {
            availableBucketsInfo =
                '\n\nAvailable buckets in your project:\n${buckets.map((b) => '  - ${b.name}').join('\n')}\n\n'
                'You can either:\n'
                '1. Update storageBucket in lib/utils/constants/supabase_config.dart to match one of the above bucket names, OR\n'
                '2. Create a new bucket named "${SupabaseConfig.storageBucket}"';
          }
        } catch (_) {
          // Can't list buckets, that's okay
        }

        throw Exception(
            'Storage bucket "${SupabaseConfig.storageBucket}" not found!$availableBucketsInfo\n\n'
            'To create a new bucket:\n'
            '1. Go to https://supabase.com/dashboard\n'
            '2. Select your project\n'
            '3. Navigate to Storage in the left sidebar\n'
            '4. Click "New bucket" or "Create bucket"\n'
            '5. Name it: "${SupabaseConfig.storageBucket}"\n'
            '6. Set it as PUBLIC (for public image access)\n'
            '7. Click "Create bucket"\n\n'
            'After creating the bucket, try uploading again.');
      }

      if (e.message.contains('violates row-level security policy')) {
        debugPrint('RLS POLICY ERROR DETECTED');
        throw Exception('Upload Failed: Permission Denied (RLS Policy)\n\n'
            'You need to configure Storage Policies in Supabase:\n'
            '1. Go to Supabase Dashboard > Storage\n'
            '2. Select bucket "${SupabaseConfig.storageBucket}"\n'
            '3. Click "Configuration" -> "Policies"\n'
            '4. Click "New Policy" -> "For full customization"\n'
            '5. Name: "Allow Public Uploads"\n'
            '6. Allowed operations: CHECK ALL (SELECT, INSERT, UPDATE, DELETE)\n'
            '7. Target roles: SELECT "anon" and "authenticated"\n'
            '8. Click "Review" then "Save"\n\n'
            'Alternatively, define the policy for specific users if needed.');
      }

      throw Exception('Storage error: ${e.message}');
    } catch (e) {
      debugPrint('General Upload Error: $e');

      // Provide more helpful error messages for other errors
      final errorString = e.toString();
      if (errorString.contains('Bucket not found') ||
          errorString.contains('404')) {
        // Try to list available buckets to help user
        String availableBucketsInfo = '';
        try {
          final buckets = await _supabase.storage.listBuckets();
          if (buckets.isNotEmpty) {
            availableBucketsInfo =
                '\n\nAvailable buckets in your project:\n${buckets.map((b) => '  - ${b.name}').join('\n')}\n\n'
                'You can either:\n'
                '1. Update storageBucket in lib/utils/constants/supabase_config.dart to match one of the above bucket names, OR\n'
                '2. Create a new bucket named "${SupabaseConfig.storageBucket}"';
          }
        } catch (_) {
          // Can't list buckets, that's okay
        }

        throw Exception(
            'Storage bucket "${SupabaseConfig.storageBucket}" not found!$availableBucketsInfo\n\n'
            'To create a new bucket:\n'
            '1. Go to https://supabase.com/dashboard\n'
            '2. Select your project\n'
            '3. Navigate to Storage in the left sidebar\n'
            '4. Click "New bucket" or "Create bucket"\n'
            '5. Name it: "${SupabaseConfig.storageBucket}"\n'
            '6. Set it as PUBLIC (for public image access)\n'
            '7. Click "Create bucket"\n\n'
            'After creating the bucket, try uploading again.');
      }

      if (errorString.contains('violates row-level security policy')) {
        debugPrint('RLS POLICY ERROR DETECTED (General Catch)');
        throw Exception('Upload Failed: Permission Denied (RLS Policy)\n\n'
            'You need to configure Storage Policies in Supabase:\n'
            '1. Go to Supabase Dashboard > Storage\n'
            '2. Select bucket "${SupabaseConfig.storageBucket}"\n'
            '3. Click "Configuration" -> "Policies"\n'
            '4. Click "New Policy" -> "For full customization"\n'
            '5. Name: "Allow Public Uploads"\n'
            '6. Allowed operations: CHECK ALL (SELECT, INSERT, UPDATE, DELETE)\n'
            '7. Target roles: SELECT "anon" and "authenticated"\n'
            '8. Click "Review" then "Save"');
      }

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
      DateTime lastFetchDate) async {
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
      // Ensure bucket exists or get an available bucket
      final bucketName = await _ensureBucketExists();

      // Delete from Supabase storage
      if (image.fullPath != null) {
        await _supabase.storage.from(bucketName).remove([image.fullPath!]);
      }

      // Delete from Firestore database
      await FirebaseFirestore.instance
          .collection('Images')
          .doc(image.id)
          .delete();
    } on io.SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
