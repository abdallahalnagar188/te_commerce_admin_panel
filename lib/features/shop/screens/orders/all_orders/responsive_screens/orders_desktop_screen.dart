import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../controllers/order/order_controller.dart';
import '../table/data_table.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading + Breadcrumbs
              const TBreadcrumbsWithHeading(
                heading: 'Orders',
                breadcrumbsItems: ['Orders'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Responsive expandable content
              Expanded(
                child: TRoundedContainer(
                  // Instead of fixed height: make it fill available height
                  child: Column(
                    children: [
                      TTableHeader(
                        showLeftWidget: false,
                        searchController: controller.searchTextController,
                        searchOnChanged: (value) => controller.searchQuery(value),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Make table take the rest of available height
                      Expanded(child: Obx(() {
                        if (controller.isLoading.value) return const TLoaderAnimation();
                        return OrdersTable();
                      })),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
