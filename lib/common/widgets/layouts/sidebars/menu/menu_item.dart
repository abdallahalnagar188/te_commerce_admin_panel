import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';

import '../../../../../features/auth/controllers/login_controller.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem({
    super.key, required this.route, required this.icon, required this.itemName,
  });

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(SidebarController());
    final loginController = Get.put(LoginController());
    return InkWell(
      onTap: () => route == 'logout'? loginController.logout(): controller.menuTap(route),
      onHover: (hovering) => hovering? controller.changeHoverItem(route): controller.changeHoverItem(''),
      child: Obx(
          () => Padding(
          padding:  EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Container(
            decoration: BoxDecoration(
                color: controller.isHover(route) || controller.isActive(route)? TColors.primary :Colors.transparent,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusMd)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.lg, top: TSizes.md, bottom: TSizes.md, right: TSizes.md),
                  child: controller.isActive(route)? Icon(icon,size: 22, color: TColors.white,) :Icon(icon,size: 22,color: controller.isHover(route) ? TColors.white:TColors.darkGrey,),
                ),

                // Text
                if(controller.isHover(route) || controller.isActive(route))
                Flexible(child: Text(itemName,style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),))
                else
                  Flexible(child: Text(itemName,style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.darkGrey),))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
