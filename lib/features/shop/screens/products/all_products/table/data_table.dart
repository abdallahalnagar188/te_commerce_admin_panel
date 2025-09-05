import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import 'product_rows.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 1000,

      columns: [
        DataColumn2(label: Text('Product'),fixedWidth: !TDeviceUtils.isDesktopScreen(context) ? 300:400),
        DataColumn2(label: Text('Stock')),
        DataColumn2(label: Text('Brand')),
        DataColumn2(label: Text('Price')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Action'),fixedWidth:  100),
      ],
      source: ProductRows(),
    );
  }
}
