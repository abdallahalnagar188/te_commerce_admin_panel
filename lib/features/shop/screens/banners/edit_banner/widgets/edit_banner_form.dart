import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../routes/app_screens.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../controllers/banner/create_banner_controller.dart';
import '../../../../controllers/banner/edit_banner_controller.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(banner);
    return  TRoundedContainer(
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
              Obx(() {
                final items = AppScreens.allAppScreenItems.toSet().toList(); // remove duplicates
                final value = items.contains(controller.targetScreen.value)
                    ? controller.targetScreen.value
                    : items.first;

                return DropdownButton<String>(
                  value: value,
                  onChanged: (String? newValue) {
                    if (newValue != null) controller.targetScreen.value = newValue;
                  },
                  items: items.map((e) =>
                      DropdownMenuItem<String>(value: e, child: Text(e))
                  ).toList(),
                );
              }),


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.updateBanner(banner),
                    child: Text('Update')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
