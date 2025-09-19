import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../models/order_model.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Information',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(
                      order.formattedOrderDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text(
                      '${order.items.length} Items',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    Obx(
                      (){
                        if(controller.statusLoader.value )return const TShimmerEffect(width: double.infinity, height: 55);
                        return TRoundedContainer(
                        radius: TSizes.cardRadiusSm,
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: TSizes.sm),
                        backgroundColor: THelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
                        child: DropdownButton<OrderStatus>(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          onChanged: (OrderStatus? newValue) {
                            if(newValue != null) {
                              controller.updateOrderStatus(order, newValue);
                            }
                          },
                          value: order.status,
                          items: OrderStatus.values.map((OrderStatus status) {
                            return DropdownMenuItem(
                                value: status,
                                child: Text(
                                  status.name.capitalize.toString(),
                                  style: TextStyle(color: THelperFunctions.getOrderStatusColor(status)),
                                ));
                          }).toList(),
                        ),
                      );}
                    ),
                  ],
                ),
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total'),
                  Text('\$${order.totalAmount}',style: Theme.of(context).textTheme.bodyLarge,)
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
