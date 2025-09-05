import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brand_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/all_customers/responsive_screens/customers_desktop.dart';


class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: CustomersDesktopScreen());
  }
}
