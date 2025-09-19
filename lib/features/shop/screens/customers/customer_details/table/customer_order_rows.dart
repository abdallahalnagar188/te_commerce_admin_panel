import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/customer/customer_details_controller.dart';
import '../../../../models/order_model.dart';

class CustomerOrderRows extends DataTableSource {
  final controller = Get.put(CustomerDetailController());
  @override
  DataRow getRow(int index) {
    final order = controller.filteredCustomerOrders[index];
    final totalAmount = order.items.fold<double>(0.0, (sum, item) => sum + item.price);

    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order),
      cells: [
        DataCell(Text(
          order.id,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge!
              .apply(color: TColors.primary),
        )),
        DataCell(Text(
          order.formattedDeliveryDate,
        )),
        DataCell(Text('${order.items.length} Items')),
        DataCell(
          TRoundedContainer(
              radius: TSizes.cardRadiusSm,
              padding: EdgeInsets.symmetric(
                  vertical: TSizes.sm, horizontal: TSizes.md),
              backgroundColor:
                  THelperFunctions.getOrderStatusColor(order.status)
                      .withOpacity(0.1),
              child: Text(
                order.status.name.capitalize.toString(),
                style: TextStyle(
                    color: THelperFunctions.getOrderStatusColor(order.status)),
              )),
        ),
        DataCell(Text('\$$totalAmount'))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((row) => row).length;
}
