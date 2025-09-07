import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';

import '../../../../data/repos/shop/category/category_repo.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';
import 'category_controller.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString image = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Init Data
  void initData(CategoryModel category) {
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    image.value = category.image;
    if (category.parentId.isNotEmpty) {
      selectedParent.value = CategoryController.instance.allItems
          .where((c) => c.id == category.parentId)
          .single;
    }
  }

  /// Method to reset Fields

  /// Pick Thumbnail Image from Media

  /// Register new Category
  Future<void> updateCategory(CategoryModel category) async {
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
      category.name = name.text.trim();
      category.image = image.value;
      category.parentId = selectedParent.value.id;
      category.isFeatured = isFeatured.value;
      category.createdAt = DateTime.now();

      // Call Repo to Create new User
      await CategoryRepo.instance.updateCategory(category);

      // Update all Data List
      CategoryController.instance.updateItemFromLists(category);

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
      ImageModel selectedImage = selectedImages.first;
      image.value = selectedImage.url;
    }
  }
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    image.value = '';
  }
}
