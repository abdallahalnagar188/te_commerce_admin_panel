import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import 'order_rows.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      columns: [
        DataColumn2(label: Text('Order Id')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Items')),
        DataColumn2(label: Text('Status'),fixedWidth: TDeviceUtils.isMobileScreen(context) ?120: null),
        DataColumn2(label: Text('Amount')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: OrderRows(),
    );
  }
}
