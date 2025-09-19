import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/device/device_utility.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller  =  Get.put(DashboardController());
    return TRoundedContainer(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(() => controller.orderStatusData.isNotEmpty
              ? SizedBox(
            height: 400,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius:
                TDeviceUtils.isTabletScreen(context) ? 80 : 55,
                startDegreeOffset: 180,
                sections: controller.orderStatusData.entries.map((entry) {
                  final OrderStatus status = entry.key;
                  final int count = entry.value;

                  return PieChartSectionData(
                    showTitle: true,
                    color:
                    THelperFunctions.getOrderStatusColor(status),
                    value: count.toDouble(),
                    title: '$count',
                    radius: TDeviceUtils.isTabletScreen(context) ? 80 : 100,
                    titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      // Handle touch events if needed
                    },
                    enabled: true
                ),
              ),
            ),
          )
              : const SizedBox(
            height: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Data Available'),
              ],
            ),
          )),

          /// Show Status and color Meta
          SizedBox(
            width:  double.infinity,
            child: Obx(
                  () => DataTable(
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Orders')),
                  DataColumn(label: Text('Total')),
                ],
                rows: controller.orderStatusData.entries.map((entry) {
                  final OrderStatus status = entry.key;
                  final int count = entry.value;
                  final totalAmount = controller.totalAmounts[status] ?? 0;

                  return DataRow(cells: [
                    DataCell(
                      Row(
                        children: [
                          TCircularContainer(
                            width: 20,
                            height: 20,
                            backgroundColor: THelperFunctions.getOrderStatusColor(status),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(controller.getDisplayStatusName(status))),
                        ],
                      ),
                    ),
                    DataCell(Text(count.toString())),
                    DataCell(
                      Text('\$${totalAmount.toStringAsFixed(2)}'), // Format as money
                    ),
                  ]);
                }).toList(),
              ),
            ),
          )
        ],
      )
    );
  }
}
