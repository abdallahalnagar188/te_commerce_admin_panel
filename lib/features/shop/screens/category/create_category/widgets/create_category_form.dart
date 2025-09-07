import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/create_category_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());
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
                'Create New Category',
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
                    labelText: 'Category name',
                    prefixIcon: Icon(Iconsax.category)),
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                () => categoryController.isLoading.value
                    ? const TShimmerEffect(width: double.infinity, height: 55)
                    : DropdownButtonFormField(
                        decoration: const InputDecoration(
                            hintText: 'Parent Category',
                            labelText: 'Parent Category',
                            prefixIcon: Icon(Iconsax.bezier)),
                        items: categoryController.allItems
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [Text(item.name)],
                                )))
                            .toList(),
                        onChanged: (newValue) =>
                            createController.selectedParent.value = newValue!),
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                () => TImageUploader(
                  imageType: createController.imageUrl.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  width: 80,
                  height: 80,
                  image: createController.imageUrl.value.isNotEmpty
                      ? createController.imageUrl.value
                      : TImages.defaultImage,
                  onIconButtonPressed: () => createController.pickImage(),
                ),
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                  ()=> CheckboxMenuButton(
                    value: createController.isFeatured.value,
                    onChanged: (value) => createController.isFeatured.value = value ?? false,
                    child: const Text('Featured')),
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => createController.createCategory(), child: Text('Create')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
