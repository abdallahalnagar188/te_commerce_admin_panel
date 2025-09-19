import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Cards
            Row(
              children: [
                Expanded(
                    child: Obx(
                  () => TDashboardCard(
                    title: 'Sales Total',
                    subTitle:
                        '\$${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                    stats: 25,
                  ),
                )),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                    child: Obx(
                  () => TDashboardCard(
                    title: 'Average Order Value',
                    subTitle:
                        '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                    stats: 15,
                  ),
                )),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                    child: Obx(
                  () => TDashboardCard(
                    title: 'Total Orders',
                    subTitle: '\$${controller.orderController.allItems.length}',
                    stats: 44,
                  ),
                )),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                    child: Obx(
                  () => TDashboardCard(
                    title: 'Visitors',
                    subTitle:
                        '${controller.customerController.allItems.length}',
                    stats: 2,
                  ),
                )),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Graphs
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      /// Bar graph
                      TWeeklySalesGraph(),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      /// Orders
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Order',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                            const DashboardOrderTable()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwSections,
                ),

                /// Pie Chart
                Expanded(child: OrderStatusPieChart())
              ],
            )
          ],
        ),
      ),
    ));
  }
}
