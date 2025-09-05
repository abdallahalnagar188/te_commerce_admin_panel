import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class CustomerRows extends DataTableSource {
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
                  'Abdallah Alnagar',
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
        DataCell(Text('abdallahAlnagar08@gmail.com')),
        DataCell(Text('01022437846')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(TTableActionButtons(
          view: true,
          edit: false,
          onViewPressed: () => Get.toNamed(TRoutes.customerDetails,arguments: UserModel.empty()),
          onDeletePressed: (){},
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
