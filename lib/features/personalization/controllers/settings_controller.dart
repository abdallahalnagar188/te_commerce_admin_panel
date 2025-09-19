import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

import '../../../data/repos/shop/setting/settings_repo.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../media/controller/media_controller.dart';
import '../models/settings_model.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<SettingModel> settings = SettingModel().obs;
  final _settingsRepo = Get.put(SettingsRepository());

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxRateController = TextEditingController();
  final shippingCostController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  @override
  void onInit() {
    fetchSettingsDetails();
    super.onInit();
  }

  Future<SettingModel> fetchSettingsDetails() async {
    try {
      loading.value = true;
      final settings = await _settingsRepo.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxRateController.text = settings.taxRate.toString();
      shippingCostController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text = settings.freeShippingThreshold.toString();

      loading.value = false;
      return settings;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
      return SettingModel();
    }
  }

  // Pick image from media
void updateAppLogo()async{
    try{
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

      if(selectedImages != null && selectedImages.isNotEmpty){
        ImageModel selectedImage = selectedImages.first;
        await _settingsRepo.updateSettingField({'appLogo': selectedImage.url});

        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        TLoaders.successSnackBar(title: "Success", message: "App Logo Updated");
      }

      loading.value = false;
    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
}

  void updateSettingInformation() async {
    try {
      loading.value = true;

      // Check Internet Connectivity
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

      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate = double.tryParse(taxRateController.text.trim()) ?? 0.0;
      settings.value.shippingCost = double.tryParse(shippingCostController.text.trim()) ?? 0.0;
      settings.value.freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      await _settingsRepo.updateSettings(settings.value);
      settings.refresh();

      loading.value = false;
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'App Settings has been updated.',
      );
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: e.toString(),
      );
    }
  }

}
