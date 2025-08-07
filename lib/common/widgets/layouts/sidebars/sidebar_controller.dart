import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

class SidebarController extends GetxController {
  static SidebarController get instance => Get.find();

  final activeItem = TRoutes.responsiveDesignTutorialScreen.obs;
  final hoverItem = ''.obs;

  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route) {
    if(activeItem.value != route){
      hoverItem.value = route;
    }
  }

  bool isActive(String route) =>activeItem.value == route;
  bool isHover(String route) =>hoverItem.value == route;

  void menuTap(String route){
    if(!isActive(route)){
      changeActiveItem(route);

      if(TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}
