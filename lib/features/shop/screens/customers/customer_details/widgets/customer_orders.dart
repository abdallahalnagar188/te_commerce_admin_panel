import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/loader_animation.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/customer/customer_details_controller.dart';
import '../table/customer_order_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.getCustomerOrders();
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(
        () {
          if(controller.ordersLoading.value) return const TLoaderAnimation();
          if(controller.allCustomerOrders.isEmpty){
            return const Center(child: Text('No Orders Found'));
          }

          final totalAmount = controller.allCustomerOrders.fold(0.0, (sum, order) => sum + order.totalAmount);
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Orders', style: Theme.of(context).textTheme.headlineMedium),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Total Spent '),
                      TextSpan(
                          text: '\$${totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary)
                      ),
                      TextSpan(
                          text: 'on ${controller.allCustomerOrders.length} Orders',
                          style: Theme.of(context).textTheme.bodyLarge
                      ),
                    ],
                  ),
                ), // Text.rich
              ],
            ), // Row
            const SizedBox(height: TSizes.spaceBtwItems),
            TextFormField(
              onChanged: (query) => controller.searchQuery(query),
              controller:  controller.searchTextController,
              decoration: const InputDecoration(
                  hintText: 'Search Orders',
                  prefixIcon: Icon(Iconsax.search_normal)
              ),
            ), // TextFormField
            const SizedBox(height: TSizes.spaceBtwSections),
            const CustomerOrderTable(),
          ],
        );}
      ), // Column
    ); // TRoundedContainer
  }
}