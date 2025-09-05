import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';

import 'package:te_commerce_admin_panel/features/shop/screens/brands/create_brand/widgets/create_brand_form.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/table/customer_order_table.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/widgets/shipping_address.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/customer_information.dart';
import '../widgets/customer_orders.dart';

class CustomerDetailsDesktopScreen extends StatelessWidget {
  const CustomerDetailsDesktopScreen({super.key});

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
              TBreadcrumbsWithHeading(heading: 'Abdallah Alnagar', breadcrumbsItems: [TRoutes.customers,'details'],returnToPreviousScreen: true,),
              SizedBox(height: TSizes.spaceBtwSections,),

              /// Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(
                    children: [
                      CustomerInfo(customer: UserModel(email: 'AbdallahAlnagar@gmail.com'),),
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
