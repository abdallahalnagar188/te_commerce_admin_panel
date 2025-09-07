import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

class SidebarController extends GetxController {
  static SidebarController get instance => Get.find();

  // Change this to your dashboard route - replace with the actual dashboard route constant
  final activeItem = TRoutes.dashboard.obs; // Change this line
  final hoverItem = ''.obs;

  @override
  void onInit() {
    super.onInit();
    activeItem.value = TRoutes.dashboard;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.currentRoute != TRoutes.dashboard) {
        Get.offNamed(TRoutes.dashboard);
      }
    });
  }


  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route) {
    if(activeItem.value != route){
      hoverItem.value = route;
    }
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHover(String route) => hoverItem.value == route;

  void menuTap(String route){
    if(!isActive(route)){
      changeActiveItem(route);

      if(TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}