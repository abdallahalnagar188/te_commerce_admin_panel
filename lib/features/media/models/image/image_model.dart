import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:te_commerce_admin_panel/utils/formatters/formatter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String fileName;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not mapped
  final DropzoneFileInterface? file; // ✅ use DropzoneFileInterface for Web
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  /// Constructor for ImageModel
  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    this.mediaCategory = '',
    required this.fileName,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
  });

  /// empty ImageModel
  static ImageModel empty() => ImageModel(url: '', folder: '', fileName: '');

  String get createdAtFormatted => TFormatter.formatDate(createdAt);

  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  /// Factory constructor from JSON
  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final doc = document.data()!;
      return ImageModel(
        id: document.id,
        url: doc['url'] ?? '',
        folder: doc['folder'] ?? '',
        sizeBytes: doc['sizeBytes'],
        mediaCategory: doc['mediaCategory'] ?? '',
        fileName: doc['fileName'] ?? '',
        fullPath: doc['fullPath'],
        createdAt: doc['createdAt'] != null
            ? DateTime.parse(doc['createdAt'])
            : null,
        updatedAt: doc['updatedAt'] != null
            ? DateTime.parse(doc['updatedAt'])
            : null,
        contentType: doc['contentType'],
      );
    } else {
      return ImageModel.empty();
    }
  }

  /// Map Firebase Storage Data
  factory ImageModel.fromFirebaseMetadata(
      FullMetadata metaData, String folder, String fileName, String downloadUrl) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      fileName: fileName,
      sizeBytes: metaData.size,
      updatedAt: metaData.updated,
      fullPath: metaData.fullPath,
      createdAt: metaData.timeCreated,
      contentType: metaData.contentType,
    );
  }

  /// Map Supabase Storage Data
  factory ImageModel.fromSupabaseMetadata(
      FileObject fileData, String folder, String fileName, String downloadUrl) {
    // Parse dates if they are strings, otherwise use as DateTime
    DateTime? parseDate(dynamic date) {
      if (date == null) return null;
      if (date is DateTime) return date;
      if (date is String) {
        try {
          return DateTime.parse(date);
        } catch (e) {
          return null;
        }
      }
      return null;
    }
    
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      fileName: fileName,
      sizeBytes: fileData.metadata?['size'] as int?,
      updatedAt: parseDate(fileData.updatedAt),
      fullPath: fileData.id,
      createdAt: parseDate(fileData.createdAt),
      contentType: fileData.metadata?['mimetype'] as String?,
    );
  }

  /// Create ImageModel from Supabase upload (simplified version)
  factory ImageModel.fromSupabaseUpload({
    required String downloadUrl,
    required String folder,
    required String fileName,
    required String fullPath,
    int? sizeBytes,
    String? contentType,
  }) {
    final now = DateTime.now();
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      fileName: fileName,
      sizeBytes: sizeBytes,
      updatedAt: now,
      fullPath: fullPath,
      createdAt: now,
      contentType: contentType ?? 'image/jpeg',
    );
  }

  /// Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'mediaCategory': mediaCategory,
      'fileName': fileName,
      'fullPath': fullPath,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'contentType': contentType,
    };
  }
}
