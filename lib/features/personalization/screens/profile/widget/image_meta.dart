import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../auth/controllers/user_controller.dart';

class ImageMeta extends StatelessWidget {
  const ImageMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TRoundedContainer(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg,horizontal: TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // User Image
              Obx(
                    () =>  TImageUploader(
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.isLoading.value,
                  onIconButtonPressed: () => controller.updateProfilePicture(),
                  imageType: controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : TImages.lightAppLogo,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              Text(controller.user.value.fullName,style: Theme.of(context).textTheme.headlineLarge,),
               Text(controller.user.value.email,style: TextStyle(color: Colors.grey),),
              const SizedBox(height: TSizes.spaceBtwSections,),
            ],
          )
        ],
      ),
    );
  }
}
