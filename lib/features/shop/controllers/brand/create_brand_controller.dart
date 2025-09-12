import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';

class CreateBrandController extends GetxController{
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageUrl = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category){
    if(selectedCategories.contains(category)){
      selectedCategories.remove(category);
    }else{
      selectedCategories.add(category);
    }
  }



  Future<void> createBrand() async {
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
      final newRecord = BrandModel(
          id: '',
          productsCount: 0,
          name: name.text.trim(),
          image: imageUrl.value,
          isFeatured: isFeatured.value,
          createdAt: DateTime.now(),
      );

      newRecord.id = await BrandRepo.instance.createBrand(newRecord);

      if(selectedCategories.isNotEmpty){
        if(newRecord.id.isEmpty) throw 'Error Storing data';

        for(var category in selectedCategories){
          final brandCategory = BrandCategoryModel(brandId: newRecord.id, categoryId: category.id);
          await BrandRepo.instance.createBrandCategory(brandCategory);
        }

        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // Update all Data List
      BrandController.instance.addItemToList(newRecord);

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
    loading(false);
    isFeatured(false);
    name.clear();
    imageUrl.value= '';
    selectedCategories.clear();
  }

}