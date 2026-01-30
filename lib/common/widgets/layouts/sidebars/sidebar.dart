import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/constants/text_strings.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import 'menu/menu_item.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
            color: TColors.white,
            border: Border(right: BorderSide(color: TColors.grey, width: 1))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
                padding: 0,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Padding(
                padding: EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      TTexts.menu.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    TMenuItem(
                      icon: Iconsax.status,
                      itemName: TTexts.dashboard.tr,
                      route: TRoutes.dashboard,
                    ),
                    TMenuItem(
                      icon: Iconsax.image,
                      itemName: TTexts.media.tr,
                      route: TRoutes.media,
                    ),
                    TMenuItem(
                      icon: Iconsax.category_2,
                      itemName: TTexts.categories.tr,
                      route: TRoutes.categories,
                    ),
                    TMenuItem(
                      icon: Iconsax.dcube,
                      itemName: TTexts.brands.tr,
                      route: TRoutes.brands,
                    ),
                    TMenuItem(
                      icon: Iconsax.picture_frame,
                      itemName: TTexts.banners.tr,
                      route: TRoutes.banners,
                    ),
                    TMenuItem(
                      icon: Iconsax.shopping_bag,
                      itemName: TTexts.products.tr,
                      route: TRoutes.products,
                    ),
                    TMenuItem(
                      icon: Iconsax.profile_2user,
                      itemName: TTexts.customers.tr,
                      route: TRoutes.customers,
                    ),
                    TMenuItem(
                      icon: Iconsax.box,
                      itemName: TTexts.orders.tr,
                      route: TRoutes.orders,
                    ),
                    Text(
                      TTexts.other.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    TMenuItem(
                      icon: Iconsax.user,
                      itemName: TTexts.profile.tr,
                      route: TRoutes.profile,
                    ),
                    TMenuItem(
                      icon: Iconsax.setting_2,
                      itemName: TTexts.settings.tr,
                      route: TRoutes.settings,
                    ),
                    TMenuItem(
                        icon: Iconsax.logout,
                        itemName: TTexts.logout.tr,
                        route: 'logout'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
