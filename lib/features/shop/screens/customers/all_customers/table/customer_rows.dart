import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;
  @override
  DataRow getRow(int index) {
final customer = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(TRoutes.customerDetails,arguments: customer,parameters: {'customerId' : customer.id ??''}),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) {
        controller.selectedRows[index] = value ?? false;
      },
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: customer.profilePicture,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ), // TRoundedImage

              const SizedBox(width: TSizes.spaceBtwItems),

              Expanded(
                child: Text(
                  customer.fullName,
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
        DataCell(Text(customer.email)),
        DataCell(Text(customer.formattedPhoneNo)),
        DataCell(Text(customer.createdAt == null ? '' : customer.createdAt.toString())),
        DataCell(TTableActionButtons(
          view: true,
          edit: false,
          onViewPressed: () => Get.toNamed(TRoutes.customerDetails,arguments:customer,parameters: {'customerId' : customer.id ??''}),
          onDeletePressed: ()=> controller.confirmAndDeleteItem(customer),
        )),
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
