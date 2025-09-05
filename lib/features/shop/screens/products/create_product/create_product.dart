import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/responsive_screens/create_product_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/responsive_screens/create_product_mobile.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CreateProductDesktopScreen(),
      mobile: CreateProductMobileScreen(),
    );
  }
}
