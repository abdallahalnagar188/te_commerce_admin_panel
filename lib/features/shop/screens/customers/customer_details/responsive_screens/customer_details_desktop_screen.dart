import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';

import 'package:te_commerce_admin_panel/features/shop/screens/brands/create_brand/widgets/create_brand_form.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/table/customer_order_table.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/widgets/shipping_address.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/customer/customer_details_controller.dart';
import '../widgets/customer_information.dart';
import '../widgets/customer_orders.dart';

class CustomerDetailsDesktopScreen extends StatelessWidget {
  const CustomerDetailsDesktopScreen({super.key, required this.customer});

  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              TBreadcrumbsWithHeading(heading: customer.fullName, breadcrumbsItems: [TRoutes.customers,'details'],returnToPreviousScreen: true,),
              SizedBox(height: TSizes.spaceBtwSections,),

              /// Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(
                    children: [
                      CustomerInfo(customer: customer),
                      const SizedBox(height: TSizes.spaceBtwSections,),
                      ShippingAddress()
                    ],
                  )),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: Column(
                    children: [
                      CustomerOrders()
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
