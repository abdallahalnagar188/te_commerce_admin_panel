import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';

class TRouteObserver extends GetObserver{


  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());

    if(previousRoute != null){
      for(var routeName  in TRoutes.sideBarMenuItems){
        if(previousRoute.settings.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }

  }
}