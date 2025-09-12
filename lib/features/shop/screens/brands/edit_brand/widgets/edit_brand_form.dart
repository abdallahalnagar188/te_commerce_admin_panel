import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/edit_brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

import '../../../../../../common/widgets/chips/rounded_choice_chips.dart';
import '../../../../models/brand_model.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());
    controller.init(brand);
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
                'Edit Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Name Text Field
              TextFormField(
                controller: controller.name,
                validator: (value) =>
                    TValidator.validateEmptyText('Name', value),
                decoration: InputDecoration(
                    labelText: 'Brand name', prefixIcon: Icon(Iconsax.box)),
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              // Categories
              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields / 2,
              ),
              Obx(
                () => Wrap(
                  spacing: TSizes.sm,
                  children: CategoryController.instance.allItems
                      .map((e) => Padding(
                            padding: EdgeInsets.only(bottom: TSizes.sm),
                            child: TChoiceChip(
                              text: e.name,
                              selected:
                                  controller.selectedCategories.contains(e),
                              onSelected: (value) =>
                                  controller.toggleSelection(e),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                    ()=> TImageUploader(
                  imageType: controller.imageUrl.value.isNotEmpty? ImageType.network:ImageType.asset,
                  width: 80,
                  height: 80,
                  image: controller.imageUrl.value.isNotEmpty ? controller.imageUrl.value:TImages.defaultImage,
                  onIconButtonPressed: () => controller.pickImage(),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                    ()=> CheckboxMenuButton(
                    value: controller.isFeatured.value,
                    onChanged: (value) => controller.isFeatured.value = value?? false,
                    child: const Text('Featured')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.updateBrand(brand), child: Text('Update')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
