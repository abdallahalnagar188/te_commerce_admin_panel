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

class BrandRows extends DataTableSource {
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
                image: TImages.adidasLogo,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ), // TRoundedImage

              const SizedBox(width: TSizes.spaceBtwItems),

              Expanded(
                child: Text(
                  'Adidas',
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
        DataCell(Padding(
          padding: EdgeInsets.symmetric(vertical: TSizes.sm),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              spacing: TSizes.xs,
              direction: TDeviceUtils.isMobileScreen(Get.context!) ? Axis.vertical : Axis.horizontal,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: TDeviceUtils.isMobileScreen(Get.context!) ? 0 : TSizes.xs),
                  child: Chip(label: Text('Shoes'), padding: EdgeInsets.all(TSizes.xs),),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: TDeviceUtils.isMobileScreen(Get.context!) ? 0 : TSizes.xs),
                  child: Chip(label: Text('TrackSuits'), padding: EdgeInsets.all(TSizes.xs),),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: TDeviceUtils.isMobileScreen(Get.context!) ? 0 : TSizes.xs),
                  child: Chip(label: Text('Joggers'), padding: EdgeInsets.all(TSizes.xs),),
                ),
              ],
            ),
          ),
        )),
        DataCell(Icon(Iconsax.heart5, color: TColors.primary,)),
        DataCell(Text(DateTime.now().toString())),
        DataCell(TTableActionButtons(
          onEditPressed: () => Get.toNamed(TRoutes.editeBrand, arguments: 'brand'),
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
