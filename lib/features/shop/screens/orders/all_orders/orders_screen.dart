import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/orders/all_orders/responsive_screens/orders_desktop_screen.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/orders/all_orders/responsive_screens/orders_mobile_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: const OrdersDesktopScreen(),
      mobile: const OrdersMobileScreen(),
    );
  }
}
