import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brand_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brand_mobile.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brand_tablet.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CreateBrandDesktopScreen(),
    );
  }
}
