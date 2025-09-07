import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';

import '../../../../controllers/category/category_controller.dart';
import 'category_rows.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return TPaginatedDataTable(
        sortColumnIndex: controller.sortColumnIndex.value,
        sortAscending: controller.sortAscending.value,
        minWidth: 700,
        columns: [
          DataColumn2(label: Text('Category'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
          DataColumn2(label: Text('Parent Category'), onSort: (columnIndex, ascending) => controller.sortByParentName(columnIndex, ascending)),
          DataColumn2(label: Text('Featured')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CategoryRows(),
      );
    });
  }
}
