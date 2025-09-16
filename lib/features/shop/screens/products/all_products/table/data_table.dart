import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../controllers/product/product_controller.dart';
import 'product_rows.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(
      () {
        Visibility(
            visible: false,
            child: Text(controller.filteredItems.length.toString()));
        Visibility(
            visible: false,
            child: Text(controller.selectedRows.length.toString()));

        return TPaginatedDataTable(
          minWidth: 1000,
          sortColumnIndex: controller.sortColumnIndex.value,
          sortAscending: controller.sortAscending.value,
          columns: [
            DataColumn2(
                label: Text('Product'),
                fixedWidth: !TDeviceUtils.isDesktopScreen(context) ? 300 : 400,
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(label: Text('Stock'), onSort: (columnIndex, ascending) => controller.sortByStock(columnIndex, ascending)),
            DataColumn2(label: Text('Sold'), onSort: (columnIndex, ascending) => controller.sortBySoldItems(columnIndex, ascending)),
            DataColumn2(label: Text('Brand')),
            DataColumn2(label: Text('Price'), onSort: (columnIndex, ascending) => controller.sortByPrice(columnIndex, ascending)),
            DataColumn2(label: Text('Date')),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: ProductRows(),
        );
      },
    );
  }
}
