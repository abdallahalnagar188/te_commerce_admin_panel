import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class BannerRows extends DataTableSource {
  final controller = BannerController.instance;

  @override
  DataRow getRow(int index) {
    final banner = controller.filteredItems[index];

    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(TRoutes.editeBanner, arguments: banner),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 180,
                height: 100,
                padding: TSizes.sm,
                image: banner.imageUrl,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ), // TRoundedImage
              // Text
            ],
          ),
        ),
        // you can add more DataCells here
        DataCell(Text(controller.formatRoute(banner.targetScreen))),
        DataCell( banner.active? Icon(Iconsax.eye, color: TColors.primary,) : Icon(Iconsax.eye_slash)),
        DataCell(TTableActionButtons(
          onEditPressed: () => Get.toNamed(TRoutes.editeBanner, arguments: banner),
          onDeletePressed: () => controller.confirmAndDeleteItem(banner),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
