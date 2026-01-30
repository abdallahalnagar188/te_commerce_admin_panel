import 'package:universal_html/html.dart' as html;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:te_commerce_admin_panel/utils/constants/supabase_config.dart';

/// Helper functions for cloud-related operations.
class TCloudHelperFunctions {
  /// Helper function to check the state of a single database record.
  ///
  /// Returns a Widget based on the state of the snapshot.
  /// If data is still loading, it returns a CircularProgressIndicator.
  /// If no data is found, it returns a generic "No Data Found" message.
  /// If an error occurs, it returns a generic error message.
  /// Otherwise, it returns null.
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Helper function to check the state of multiple (list) database records.
  ///
  /// Returns a Widget based on the state of the snapshot.
  /// If data is still loading, it returns a CircularProgressIndicator.
  /// If no data is found, it returns a generic "No Data Found" message or a custom nothingFoundWidget if provided.
  /// If an error occurs, it returns a generic error message.
  /// Otherwise, it returns null.
  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Create a reference with an initial file path and name and retrieve the download URL.
  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';
      final supabase = Supabase.instance.client;
      final url = supabase.storage
          .from(SupabaseConfig.storageBucket)
          .getPublicUrl(path);
      return url;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  /// Retrieve the download URL from a given storage URI.
  /// For Supabase, if the URL is already a public URL, return it as is.
  /// Otherwise, extract the path and get the public URL.
  static Future<String> getURLFromURI(String url) async {
    try {
      if (url.isEmpty) return '';

      // If it's already a Supabase public URL, return it
      if (url.contains(SupabaseConfig.supabaseUrl)) {
        return url;
      }

      // Otherwise, try to extract path and get public URL
      // This is a fallback for compatibility
      final supabase = Supabase.instance.client;
      // Extract path from URL if possible, otherwise use URL as path
      final path = url.replaceFirst(
          '${SupabaseConfig.supabaseUrl}/storage/v1/object/public/${SupabaseConfig.storageBucket}/',
          '');
      final downloadUrl = supabase.storage
          .from(SupabaseConfig.storageBucket)
          .getPublicUrl(path);
      return downloadUrl;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  /// Upload any Image using File
  static Future<String> uploadImageFile(
      {required html.File file,
      required String path,
      required String imageName}) async {
    try {
      final supabase = Supabase.instance.client;
      final filePath = '$path/$imageName';

      // Read file as bytes
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;
      final bytes = reader.result as List<int>;

      // Determine content type
      String contentType = 'image/jpeg';
      if (imageName.toLowerCase().endsWith('.png')) {
        contentType = 'image/png';
      } else if (imageName.toLowerCase().endsWith('.gif')) {
        contentType = 'image/gif';
      } else if (imageName.toLowerCase().endsWith('.webp')) {
        contentType = 'image/webp';
      }

      // Upload to Supabase storage
      await supabase.storage.from(SupabaseConfig.storageBucket).uploadBinary(
            filePath,
            Uint8List.fromList(bytes),
            fileOptions: FileOptions(
              upsert: true,
              contentType: contentType,
            ),
          );

      // Get public URL
      final String downloadURL = supabase.storage
          .from(SupabaseConfig.storageBucket)
          .getPublicUrl(filePath);

      // Return the download URL
      return downloadURL;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> deleteFileFromStorage(String downloadUrl) async {
    try {
      final supabase = Supabase.instance.client;

      // Extract path from Supabase URL
      // URL format: https://[project].supabase.co/storage/v1/object/public/[bucket]/[path]
      String? filePath;
      if (downloadUrl.contains('/storage/v1/object/public/')) {
        final parts = downloadUrl.split('/storage/v1/object/public/');
        if (parts.length > 1) {
          final pathParts = parts[1].split('/');
          if (pathParts.length > 1) {
            // Remove bucket name and get the rest as path
            filePath = pathParts.sublist(1).join('/');
          }
        }
      }

      if (filePath == null) {
        throw Exception('Could not extract file path from URL');
      }

      await supabase.storage
          .from(SupabaseConfig.storageBucket)
          .remove([filePath]);

      print('File deleted successfully.');
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
