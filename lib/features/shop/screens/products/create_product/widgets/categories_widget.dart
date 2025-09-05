import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../data/repos/shop/CategoryModel.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample categories data
    final List<CategoryModel> categories = [
      CategoryModel(id: '1', name: 'Shoes', image: 'assets/shoes.png'),
      CategoryModel(id: '2', name: 'Shirts', image: 'assets/shirts.png'),
      CategoryModel(id: '3', name: 'Pants', image: 'assets/pants.png'),
      CategoryModel(id: '4', name: 'Accessories', image: 'assets/accessories.png'),
      CategoryModel(id: '5', name: 'Electronics', image: 'assets/electronics.png'),
    ];

    // Convert to MultiSelectItem
    final List<MultiSelectItem<CategoryModel>> multiSelectItems = categories
        .map((category) => MultiSelectItem<CategoryModel>(category, category.name))
        .toList();

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16), // Using fixed value instead of TSizes.spaceBtnItems

          // MultiSelectDialogField for selecting categories

             MultiSelectDialogField<CategoryModel>(
              items: multiSelectItems,
              title: const Text("Categories"),
              buttonText: const Text("Select Categories"),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                // Handle selected categories
                debugPrint('Selected categories: ${values.map((e) => e.name).toList()}');
              },
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              // dialogHeight: MediaQuery.of(context).size.height * 0.7,
            ),

        ],
      ), // Column
    ); // TRoundedContainer
  }
}