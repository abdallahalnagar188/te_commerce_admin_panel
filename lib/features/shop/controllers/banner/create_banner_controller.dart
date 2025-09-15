import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/banners/banners_repo.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/routes/app_screens.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';
import '../../models/banner_model.dart';

class CreateBannerController extends GetxController{
  static CreateBannerController get instance => Get.find();

  final loading = false.obs;
  final imageUrl = ''.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();


  Future<void> createBanner() async {
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
      final newRecord = BannerModel(
        id: '',
        imageUrl: imageUrl.value,
        targetScreen: targetScreen.value,
        active: isActive.value,
      );

      newRecord.id =  await BannersRepo.instance.createBanner(newRecord);

      BannerController.instance.addItemToList(newRecord);

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


}