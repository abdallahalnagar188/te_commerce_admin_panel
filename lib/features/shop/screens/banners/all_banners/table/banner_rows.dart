import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class BannerRows extends DataTableSource {
  @override
  DataRow getRow(int index) {
    // final category = categories[index]; // assuming you have a categories list

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 180,
                height: 100,
                padding: TSizes.sm,
                image: TImages.banner1,
                imageType: ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ), // TRoundedImage
              // Text
            ],
          ),
        ),
        // you can add more DataCells here
        DataCell(Text('Shop')),
        DataCell(Icon(Iconsax.eye, color: TColors.primary,)),
        DataCell(TTableActionButtons(
          onEditPressed: () => Get.toNamed(TRoutes.editeBanner, arguments: 'banner'),
          onDeletePressed: () {},
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
