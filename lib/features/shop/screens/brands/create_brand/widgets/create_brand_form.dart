import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/create_brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/create_category_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateBrandController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: createController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(
                height: TSizes.sm,
              ),
              Text(
                'Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Name Text Field
              TextFormField(
                controller: createController.name,
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
                      .map((element) => Padding(
                            padding: EdgeInsets.only(bottom: TSizes.sm),
                            child: TChoiceChip(
                              text: element.name,
                              selected: createController.selectedCategories
                                  .contains(element),
                              onSelected: (value) =>
                                  createController.toggleSelection(element),
                            ),
                          )).toList(),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                ()=> TImageUploader(
                  imageType: createController.imageUrl.value.isNotEmpty? ImageType.network:ImageType.asset,
                  width: 80,
                  height: 80,
                  image: createController.imageUrl.value.isNotEmpty ? createController.imageUrl.value:TImages.defaultImage,
                  onIconButtonPressed: () => createController.pickImage(),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                  ()=> CheckboxMenuButton(
                    value: createController.isFeatured.value,
                    onChanged: (value) => createController.isFeatured.value = value?? false,
                    child: const Text('Featured')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => createController.createBrand(), child: Text('Create')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
