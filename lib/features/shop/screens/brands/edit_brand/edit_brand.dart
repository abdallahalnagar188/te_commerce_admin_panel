import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brand_desktop.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return TSiteTemplate(
      desktop: EditBrandDesktopScreen(brand:brand ,),
    );
  }
}
