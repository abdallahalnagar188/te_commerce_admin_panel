import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/category/category_repo.dart';
import 'package:te_commerce_admin_panel/features/media/controller/media_controller.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:te_commerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageUrl = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Method to reset Fields

  /// Pick Thumbnail Image from Media

  /// Register new Category
  Future<void> createCategory() async {
    try {
      // Start Loading
      TFullScreenLoader.popUpCircular();

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      final newRecord = CategoryModel(
          id: '',
          name: name.text.trim(),
          image: imageUrl.value,
          isFeatured: isFeatured.value,
          createdAt: DateTime.now(),
          parentId: selectedParent.value.id
      );

      newRecord.id = await CategoryRepo.instance.createCategory(newRecord);

      // Update all Data List
      CategoryController.instance.addItemToList(newRecord);

      resetFields();

      // Remove Loading
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulation', message: 'New Record has been added');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel image = selectedImages.first;
      imageUrl.value = image.url;
    }
  }

  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageUrl.value= '';
  }
}
