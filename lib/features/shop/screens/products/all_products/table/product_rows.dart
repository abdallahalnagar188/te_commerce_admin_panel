import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_controller.dart';

class ProductRows extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) {
        controller.selectedRows[index] = value ?? false;
      },
      onTap: () {

            Get.toNamed(TRoutes.editeProduct, arguments: product);
            if (kDebugMode) {
              print(product.brand?.image.toString());
            }
      },
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: product.thumbnail,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Flexible(
                  child: Text(
                product.title,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: TColors.primary),
              ))
            ],
          ),
        ),
        // you can add more DataCells here
        // stock data cell
        DataCell( Text(product.stock.toString())),
        DataCell(Text(product.soldQuantity.toString())),

        // Brand
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 35,
                height: 35,
                padding: TSizes.xs,
                image: product.brand!.image,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Flexible(
                  child: Text(
                product.brand != null ? product.brand!.name : '',
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: TColors.primary),
              ))
            ],
          ),
        ),
        DataCell(Text('\$${controller.getProductPrice(product)}')),
        DataCell(Text(product.formattedDate)),
        DataCell(TTableActionButtons(
          onEditPressed: () =>
              Get.toNamed(TRoutes.editeProduct, arguments: product),
          onDeletePressed: () => controller.confirmAndDeleteItem(product),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
