import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repos/shop/brand/brand_repo.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';
import '../../models/brand_category_model.dart';
import '../../models/brand_model.dart';
import '../../models/category_model.dart';
import 'brand_controller.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageUrl = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Init Data
  void init(BrandModel brand) {
    name.text = brand.name;
    imageUrl.value = brand.image;
    isFeatured.value = brand.isFeatured!;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
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

      bool isBrandUpdated = false;
      if (brand.image != imageUrl.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;
        // Map Data
        brand.name = name.text.trim();
        brand.image = imageUrl.value;
        brand.isFeatured = isFeatured.value;
        brand.createdAt = DateTime.now();

        // Call repo to update
        await BrandRepo.instance.updateBrand(brand);
      }

      // Update BrandCategories
      if(selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      if(isBrandUpdated) await updateBrandInProducts(brand);


      // Update all Data List
      BrandController.instance.updateItemFromLists(brand);


      refresh();

      // Remove Loading
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulation', message: 'New Record has been Updated');
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
    loading(false);
    isFeatured(false);
    name.clear();
    imageUrl.value = '';
    selectedCategories.clear();
  }

  // Update categories of this brand
  Future<void> updateBrandCategories(BrandModel brand) async {
    // Fetch all BrandCategories
    final brandCategories = await BrandRepo.instance.getCategoriesOfSpecificBrand(brand.id);

    // SelectedCategoryIds
    final selectedCategoryIds = selectedCategories.map((e) => e.id);

    // Identify categories to remove
    final categoriesToRemove =
    brandCategories.where((existingCategory) => !selectedCategoryIds.contains(existingCategory.categoryId)).toList();

    // Remove unselected categories
    for (var categoryToRemove in categoriesToRemove) {
      await BrandRepo.instance.deleteBrandCategory(categoryToRemove.id ?? '');
    }

    // Identify new categories to add
    final newCategoriesToAdd = selectedCategories
        .where((newCategory) => !brandCategories.any((existingCategory) => existingCategory.categoryId == newCategory.id))
        .toList();

    // Add new categories
    for (var newCategory in newCategoriesToAdd) {
      var brandCategory = BrandCategoryModel(brandId: brand.id, categoryId: newCategory.id);
      brandCategory.id = await BrandRepo.instance.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemFromLists(brand);
  }

  Future<void> updateBrandInProducts(BrandModel brand) async {}

}
