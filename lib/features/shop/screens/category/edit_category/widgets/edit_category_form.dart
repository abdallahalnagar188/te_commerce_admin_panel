import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

import '../../../../../../common/widgets/shimmers/shimmer.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    final categoryController = Get.put(CategoryController());
    editController.initData(category);
    if (kDebugMode) {
      print(editController.selectedParent.value.name + category.name);
    }
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: editController.formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const SizedBox(
            height: TSizes.sm,
          ),
          Text(
            'Update Category',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Name Text Field
           TextFormField(
              controller: editController.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: InputDecoration(
                  labelText: 'Category name', prefixIcon: Icon(Iconsax.category)),
            ),


          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          Obx(
            () => editController.loading.value
                ? const TShimmerEffect(width: double.infinity, height: 55)
                : DropdownButtonFormField(
                    decoration: const InputDecoration(
                        hintText: 'Parent Category',
                        labelText: 'Parent Category',
                        prefixIcon: Icon(Iconsax.bezier)),
                    value: editController.selectedParent.value.id.isNotEmpty? editController.selectedParent.value:null,
                    items: categoryController.allItems
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text(item.name)],
                            )))
                        .toList(),
                    onChanged: (newValue) =>
                        editController.selectedParent.value = newValue!),
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          Obx(
            () => TImageUploader(
              imageType: editController.image.value.isNotEmpty
                  ? ImageType.network
                  : ImageType.asset,
              width: 80,
              height: 80,
              image: editController.image.value.isNotEmpty
                  ? editController.image.value
                  : TImages.defaultImage,
              onIconButtonPressed: () => editController.pickImage(),
            ),
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          Obx(
            () => CheckboxMenuButton(
                value: editController.isFeatured.value,
                onChanged: (value) =>
                    editController.isFeatured.value = value ?? false,
                child: const Text('Featured')),
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => editController.updateCategory(category),
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
