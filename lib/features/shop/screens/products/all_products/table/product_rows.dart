import 'package:data_table_2/data_table_2.dart';
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

class ProductRows extends DataTableSource {
  @override
  DataRow getRow(int index) {
    // final category = categories[index]; // assuming you have a categories list

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: TImages.productImage1,
                imageType: ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems,),
              Flexible(child: Text('Product Title',style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),))
            ],
          ),
        ),
        // you can add more DataCells here
        DataCell(Text('265')),

        // Brand
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 35,
                height: 35,
                padding: TSizes.xs,
                image: TImages.nikeLogo,
                imageType: ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems,),
              Flexible(child: Text('Nike',style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),))
            ],
          ),
        ),
        DataCell(Text('\$99.9')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(TTableActionButtons(
          onEditPressed: () => Get.toNamed(TRoutes.editeProduct, arguments: 'product'),
          onDeletePressed: () {},
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
