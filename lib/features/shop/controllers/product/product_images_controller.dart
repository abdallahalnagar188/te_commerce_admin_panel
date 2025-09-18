import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/media/controller/media_controller.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';

import '../../models/product_varation_model.dart';

class ProductImageController extends GetxController {
  static ProductImageController get instance => Get.find();

  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  final RxList<String> additionalProductImagesUrls = <String>[].obs;


  /// Pick Thumbnail Image from Media
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handel the selected image
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  /// Pick Multiple Images from Media
  void selectMultipleProductImages() async {
    final controller =Get.put(MediaController());
    final selectedImages = await controller.selectImagesFromMedia(
        multipleSelection: true, selectedUrls: additionalProductImagesUrls);

    // Handel the selected image
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  void selectVariationImage(ProductVariationModel variation) async {
    final controller = MediaController.instance;
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handel the selected image
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      variation.image.value = selectedImage.url;
    }
  }

  ///Function to remove product image
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }
}
