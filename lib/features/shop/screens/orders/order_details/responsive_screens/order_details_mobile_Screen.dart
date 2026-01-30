import 'package:flutter/material.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';
import '../widgets/order_customer.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transactions.dart';

class OrderDetailsMobileScreen extends StatelessWidget {
  const OrderDetailsMobileScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              TBreadcrumbsWithHeading(
                heading: order.id,
                breadcrumbsItems: const [TRoutes.orderDetails, 'details'],
                returnToPreviousScreen: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Body - Stacked for Mobile
              Column(
                children: [
                  // Order info
                  OrderInfo(order: order),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Items
                  OrderItems(order: order),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Transactions
                  OrderTransactions(order: order),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // OrderCustomer
                  OrderCustomer(order: order),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
