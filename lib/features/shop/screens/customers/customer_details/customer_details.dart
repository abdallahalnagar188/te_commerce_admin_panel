import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/customers/customer_details/responsive_screens/customer_details_desktop_screen.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CustomerDetailsDesktopScreen(),
    );
  }
}
