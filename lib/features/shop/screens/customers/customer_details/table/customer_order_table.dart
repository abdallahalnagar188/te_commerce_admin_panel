import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/table/customer_order_rows.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controllers/customer/customer_details_controller.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    return Obx(
      (){
        Visibility(visible: false, child: Text(controller.filteredCustomerOrders.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        return TPaginatedDataTable(
        minWidth: 550,
        tableHeight: 640,
        dataRowHeight: kMinInteractiveDimension,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(label: Text('Order Id'), onSort: (int columnIndex, bool ascending) => controller.sortById(columnIndex, ascending),),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Items')),
          DataColumn2(label: Text('Status'),fixedWidth: TDeviceUtils.isMobileScreen(context) ?100: null),
          DataColumn2(label: Text('Amount'), numeric: true),
        ],
        source: CustomerOrderRows(),
      );}
    );
  }
}
