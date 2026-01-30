import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:te_commerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:te_commerce_admin_panel/features/auth/controllers/user_controller.dart';
import 'package:te_commerce_admin_panel/common/controllers/language_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../utils/constants/image_strings.dart';

class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        border: Border(bottom: BorderSide(color: TColors.grey, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(
        /// Mobile menu
        automaticallyImplyLeading: !TDeviceUtils.isDesktopScreen(context),
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: Icon(Iconsax.menu))
            : null,

        /// Search Field
        title: TDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Searching anything...'),
                ),
              )
            : null,

        actions: [
          /// Search Icon in Mobile
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(onPressed: () {}, icon: Icon(Iconsax.search_normal)),

          /// Notification Icon
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification)),

          /// Language Switcher
          IconButton(
            onPressed: () => Get.put(LanguageController()).changeLanguage(),
            icon: const Icon(Iconsax.translate),
          ),

          /// User data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => TRoundedImage(
                  width: 40,
                  height: 40,
                  padding: 2,
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : TImages.user,
                ),
              ),
              const SizedBox(
                width: TSizes.sm,
              ),
              if (!TDeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.isLoading.value
                          ? const TShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                      controller.isLoading.value
                          ? const TShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.email,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                    ],
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
