import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../controllers/customer/customer_controller.dart';
import 'customer_rows.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());

    return Obx(
      () {
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());

        return TPaginatedDataTable(
        minWidth: 700,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(label: Text('Customers'),onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
          DataColumn2(label: Text('Email')),
          DataColumn2(label: Text('Phone Number')),
          DataColumn2(label: Text('Registered')),
          DataColumn2(label: Text('Action'),fixedWidth: 100),
        ],
        source: CustomerRows(),
      );}
    );
  }
}
