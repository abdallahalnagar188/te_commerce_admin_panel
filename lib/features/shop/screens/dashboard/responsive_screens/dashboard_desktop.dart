
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImageController());
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Heading
                Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge,),
                // ElevatedButton(onPressed: () => controller.selectThumbnailImage(), child: Text('Selected Single Image')),
                // const SizedBox(height: TSizes.spaceBtwSections,),
                // ElevatedButton(onPressed: () => controller.selectMultipleProductImages(), child: Text('Selected Multiple Single Image')),
                const SizedBox(height: TSizes.spaceBtwSections,),


                /// Cards
                Row(
                  children: [
                    Expanded(
                        child: TDashboardCard(
                          title: 'Sales Total',
                          subTitle: '\$356.6',
                          stats: 25,
                        )),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                        child: TDashboardCard(
                          title: 'Average Order Value',
                          subTitle: '\$25.6',
                          stats: 15,
                        )),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                        child: TDashboardCard(
                          title: 'Total Orders',
                          subTitle: '\$35',
                          stats: 44,
                        )),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                        child: TDashboardCard(
                          title: 'Visitors',
                          subTitle: '254,034',
                          stats: 2,
                        )),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),

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
                          const SizedBox(height: TSizes.spaceBtwSections,),

                          /// Orders
                          TRoundedContainer(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,children: [
                                Text('Recent Order',style: Theme.of(context).textTheme.headlineSmall,),
                              const SizedBox(height: TSizes.spaceBtwSections,),
                              const DashboardOrderTable()
                            ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwSections,),

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