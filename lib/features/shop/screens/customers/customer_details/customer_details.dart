import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/responsive_screens/customer_details_desktop_screen.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../../auth/models/user_model.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Explicit cast
    final customer = Get.arguments as UserModel?;
    final customerId = Get.parameters['customerId'];

    if (customer == null) {
      return Scaffold(
        body: Center(
          child: Text("Customer data not found for ID: $customerId"),
        ),
      );
    }

    return TSiteTemplate(
      desktop: CustomerDetailsDesktopScreen(customer: customer),
    );
  }
}

