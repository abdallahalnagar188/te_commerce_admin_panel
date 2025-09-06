import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/widgets/shipping_address.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';
import '../widgets/order_customer.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transactions.dart';

class OrderDetailsDesktopScreen extends StatelessWidget {
  const OrderDetailsDesktopScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              TBreadcrumbsWithHeading(
                heading: order.id,
                breadcrumbsItems: [TRoutes.orderDetails, 'details'],
                returnToPreviousScreen: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Order info
                          OrderInfo(order: order),
                          const SizedBox(height: TSizes.spaceBtwSections,),

                          // Items
                          OrderItems(order: order),
                          const SizedBox(height: TSizes.spaceBtwSections,),

                          // Transactions
                          OrderTransactions(order: order)
                        ],
                      )),
                  const SizedBox(width: TSizes.spaceBtwSections,),
                  Expanded(
                      child: Column(
                    children: [
                      // OrderCustomer
                      OrderCustomer(order: order),
                      const SizedBox(height: TSizes.spaceBtwSections,),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
