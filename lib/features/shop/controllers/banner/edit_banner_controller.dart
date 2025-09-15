import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/banners/banners_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/models/banner_model.dart';

import '../../../../data/repos/shop/brand/brand_repo.dart';
import '../../../../routes/app_screens.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';
import '../../models/brand_category_model.dart';
import '../../models/brand_model.dart';
import '../../models/category_model.dart';
import 'banner_controller.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final loading = false.obs;
  final imageUrl = ''.obs;
  final isActive = false.obs;
  final targetScreen =''.obs;
  final formKey = GlobalKey<FormState>();
  final repo = Get.put(BannersRepo());

  /// Init Data
  void init(BannerModel banner) {
    imageUrl.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;

  }



  Future<void> updateBanner(BannerModel banner) async {
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


      if(banner.imageUrl != imageUrl.value || banner.active != isActive.value || banner.targetScreen != targetScreen.value){
        banner.imageUrl = imageUrl.value;
        banner.active = isActive.value;
        banner.targetScreen = targetScreen.value;

        // call repo to update
        await repo.updateBrand(banner);

      }

      BannerController.instance.updateItemFromLists(banner);


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

  //
  // void resetFields() {
  //   loading(false);
  //   isFeatured(false);
  //   name.clear();
  //   imageUrl.value = '';
  //   selectedCategories.clear();
  // }


}
