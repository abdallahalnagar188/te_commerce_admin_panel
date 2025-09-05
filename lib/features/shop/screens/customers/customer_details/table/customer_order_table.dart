import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/table/customer_order_rows.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 550,
      tableHeight: 640,
      dataRowHeight: kMinInteractiveDimension,
      columns: [
        DataColumn2(label: Text('Order Id')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Items')),
        DataColumn2(label: Text('Status'),fixedWidth: TDeviceUtils.isMobileScreen(context) ?100: null),
        DataColumn2(label: Text('Amount'), numeric: true),
      ],
      source: CustomerOrderRows(),
    );
  }
}
