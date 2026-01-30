import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/circular_loader.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/popups/dialogs.dart';
import 'package:te_commerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';
import 'package:te_commerce_admin_panel/data/repos/media/media_repo.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../screens/media/widgets/mdia_content.dart';
import '../screens/media/widgets/media_uploader.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;
  final RxBool showImagesUploaderSection = false.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

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

  void getMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }

      final images = await mediaRepo.fetchImagesFromDatabase(
        selectedPath.value,
        initialLoadCount,
      );

      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Unable to fetch images, Somthing went wrong : $e');
      print(e.toString());
    }
  }

  void loadMoreMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }

      final images = await mediaRepo.loadMoreImagesFromDatabase(
          selectedPath.value,
          loadMoreCount,
          targetList.last.createdAt ?? DateTime.now());

      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Unable to fetch images, Somthing went wrong : $e');
    }
  }

  /// Pick images (Web & Mobile)
  Future<void> selectLocalImage() async {
    if (kIsWeb) {
      // Web Logic using Dropzone (if initialized) or fallback if needed (though Dropzone usually handles it)
      // Note: DropzoneViewController.pickFiles might rely on the view being present.
      // If the view checks kIsWeb, it's fine.
      try {
        final files = await dropzoneViewController.pickFiles(
          multiple: true,
          mime: ['image/jpeg', 'image/png'],
        );

        if (files.isNotEmpty) {
          for (var file in files) {
            processWebFile(file);
          }
        }
      } catch (e) {
        debugPrint('Web Picker Error: $e');
      }
    } else {
      // Mobile Logic using ImagePicker
      try {
        final ImagePicker picker = ImagePicker();
        final List<XFile> images =
            await picker.pickMultiImage(imageQuality: 70);

        if (images.isNotEmpty) {
          for (var file in images) {
            await _processMobileFile(file);
          }
        }
      } catch (e) {
        debugPrint('Mobile Picker Error: $e');
      }
    }
  }

  Future<void> processWebFile(dynamic file) async {
    try {
      final bytes = await dropzoneViewController.getFileData(file);
      final image = ImageModel(
        url: '',
        file: file,
        folder: '',
        fileName: file.name,
        localImageToDisplay: Uint8List.fromList(bytes),
      );
      selectedImagesToUpload.add(image);
    } catch (e) {
      debugPrint('Error processing web file ${file.name}: $e');
    }
  }

  Future<void> _processMobileFile(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = ImageModel(
        url: '',
        file: null, // No html.File on mobile
        folder: '',
        fileName: file.name,
        localImageToDisplay: bytes,
      );
      selectedImagesToUpload.add(image);
    } catch (e) {
      debugPrint('Error processing mobile file ${file.name}: $e');
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

        // Upload Image to Supabase Storage
        final ImageModel uploadedImage =
            await mediaRepo.uploadImageFileInStorage(
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

  void removeCloudImageConfirmation(ImageModel image) {
    TDialogs.defaultDialog(
        context: Get.context!,
        content: 'Are Your sure you want to delete this image',
        onConfirm: () {
          Get.back();
          removeCloudImage(image);
        });
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

  void removeCloudImage(ImageModel image) async {
    try {
      Get.back();

      // show Loader
      Get.defaultDialog(
          title: '',
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: PopScope(
              canPop: false,
              child: SizedBox(
                width: 150,
                height: 150,
                child: TCircularLoader(),
              )));

      // Delete Image
      await mediaRepo.deleteFileFromStorage(image);
      RxList<ImageModel> targetList;

      switch (selectedPath.value) {
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

      targetList.remove(image);
      update();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Image Deleted',
          message: 'Image Successfully deleted from the cloud storage');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Images Selection Bottom Sheet
  Future<List<ImageModel>?> selectImagesFromMedia({
    List<String>? selectedUrls,
    bool allowSelection = true,
    bool multipleSelection = false,
  }) async {
    showImagesUploaderSection.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: TColors.primaryBackground,
      FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const MediaUploader(),
                MediaContent(
                  allowSelection: allowSelection,
                  alreadySelectedUrls: selectedUrls ?? [],
                  allowMultipleSelection: multipleSelection,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return selectedImages;
  }
}
