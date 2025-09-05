import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/edit_banner/responsive_screens/edit_banner_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/edit_product/responsive_screens/edit_product_mobile.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: EditProductDesktopScreen(),
      mobile: EditProductMobileScreen(),
    );
  }
}
