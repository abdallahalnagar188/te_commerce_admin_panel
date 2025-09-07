import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class CategoryRows extends DataTableSource {
  final controller = CategoryController.instance;

  @override
  DataRow getRow(int index) {
    final category = controller.filteredItems[index];
    final parentCategory = controller.allItems.firstWhereOrNull((item) => item.id == category.parentId);
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: category.image,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ), // TRoundedImage

              const SizedBox(width: TSizes.spaceBtwItems),

              Expanded(
                child: Text(
                  category.name,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ), // Text
            ],
          ),
        ),
        // you can add more DataCells here
        DataCell(Text(parentCategory != null ? parentCategory.name : '')),
        DataCell(category.isFeatured
            ? Icon(
                Iconsax.heart5,
                color: TColors.primary,
              )
            : Icon(Iconsax.heart)),
        DataCell(
            Text(category.createdAt == null ? "" : category.formattedDate)),
        DataCell(TTableActionButtons(
          onEditPressed: () =>
              Get.toNamed(TRoutes.editeCategory, arguments: category),
          onDeletePressed: () => controller.confirmAndDeleteItem(category),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}
