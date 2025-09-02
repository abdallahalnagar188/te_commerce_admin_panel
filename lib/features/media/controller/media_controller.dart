import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/popups/dialogs.dart';
import 'package:te_commerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';
import 'package:te_commerce_admin_panel/data/repos/media/media_repo.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneViewController;
  final RxBool showImageUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepo = MediaRepository();

  /// Pick images using Dropzone (web only)
  Future<void> selectLocalImage() async {
    final files = await dropzoneViewController.pickFiles(
      multiple: true,
      mime: ['image/jpeg', 'image/png'],
    );

    if (files.isNotEmpty) {
      for (var file in files) {
        try {
          final bytes = await dropzoneViewController.getFileData(file);

          final image = ImageModel(
            url: '',
            file: file, // html.File directly
            folder: '',
            fileName: file.name,
            localImageToDisplay: Uint8List.fromList(bytes),
          );

          selectedImagesToUpload.add(image);
        } catch (e) {
          debugPrint('Error processing file ${file.name}: $e');
        }
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
        title: 'Select Folder',
        message: 'Please select the folder in order to upload the image.',
      );
      return;
    }
    TDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content:
      'Are you sure you want to upload all these images in ${selectedPath.value.name} folder?',
    );
  }

  Future<void> uploadImages() async {
    try {
      Get.back(); // close dialog
      uploadImagesLoader();

      MediaCategory selectedCategory = selectedPath.value;

      RxList<ImageModel> targetList;
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];

        // Upload Image to Firebase Storage
        final ImageModel uploadedImage = await mediaRepo.uploadImageFileInStorage(
          bytes: selectedImage.localImageToDisplay!, // ✅ use Uint8List
          path: getSelectedPath(),
          imageName: selectedImage.fileName,
        );


        uploadedImage.mediaCategory = selectedCategory.name;

        // Save in Firestore
        final id = await mediaRepo.uploadImageFileInDatabase(uploadedImage);
        uploadedImage.id = id;

        // Update lists
        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }

      TFullScreenLoader.stopLoading();
    } catch (e, st) {
      TFullScreenLoader.stopLoading();
      debugPrint("UPLOAD ERROR: $e");
      debugPrint("STACK: $st");
      TLoaders.warningSnackBar(
        title: 'Error Uploading Image',
        message: 'Something went wrong while uploading images $e',
      );
    }
  }


String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Uploading Images'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    TImages.uploadingImageIllustration,
                    height: 300,
                    width: 300,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Text('Sit Tight, Your Images are Uploading...')
                ],
              ),
            )));
  }
}
