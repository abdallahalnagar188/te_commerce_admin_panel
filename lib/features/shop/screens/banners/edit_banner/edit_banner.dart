import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/edit_banner/responsive_screens/edit_banner_desktop.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return TSiteTemplate(
      desktop: EditBannerDesktopScreen(banner: banner,),
    );
  }
}
