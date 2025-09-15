import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:te_commerce_admin_panel/routes/app_screens.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

import '../../../../controllers/banner/create_banner_controller.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(
                height: TSizes.sm,
              ),
              Text(
                'Create New Banner',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              Column(
                children: [
                  Obx(
                    () => GestureDetector(
                      child: TRoundedImage(
                        width: 400,
                        height: 200,
                        backgroundColor: TColors.primaryBackground,
                        image: controller.imageUrl.value.isNotEmpty
                            ? controller.imageUrl.value
                            : TImages.defaultImage,
                        imageType: controller.imageUrl.value.isNotEmpty
                            ? ImageType.network
                            : ImageType.asset,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TextButton(
                      onPressed: () => controller.pickImage(),
                      child: Text('Select Image'))
                ],
              ),

              Text(
                'Make your Banner Active or InActive',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              Obx(() => CheckboxMenuButton(
                    value: controller.isActive.value,
                    onChanged: (value) =>
                        controller.isActive.value = value ?? false,
                    child: const Text('Active'),
                  )),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Dropdown Menu Screens
              Obx(
                ()=> DropdownButton<String>(
                  value: controller.targetScreen.value,
                  onChanged: (String? newValue) =>
                      controller.targetScreen.value = newValue!,
                  items: AppScreens.allAppScreenItems
                      .map<DropdownMenuItem<String>>((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.createBanner(),
                    child: Text('Create')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
