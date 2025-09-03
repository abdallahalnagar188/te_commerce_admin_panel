import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brand_mobile.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brand_tablet.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: EditBrandDesktopScreen(),

    );
  }
}
