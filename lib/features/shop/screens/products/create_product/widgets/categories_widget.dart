import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/product_model.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../../../models/category_model.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample categories data
    final categoryController = Get.put(CategoryController());

    if (categoryController.allItems.isEmpty) {
      categoryController.fetchItems();
    }

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          // Using fixed value instead of TSizes.spaceBtnItems
          Obx(
            () => categoryController.isLoading.value
                ? const TShimmerEffect(width: double.infinity, height: 50)
                : MultiSelectDialogField<CategoryModel>(
                    items: categoryController.allItems
                        .map((category) => MultiSelectItem<CategoryModel>(
                            category, category.name))
                        .toList(),
                    title: const Text("Categories"),
                    buttonText: const Text("Select Categories"),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      // Handle selected categories
                      CreateProductController.instance.selectedCategories
                          .assignAll(values);
                    },
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // dialogHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
          ),
        ],
      ), // Column
    ); // TRoundedContainer
  }
}
