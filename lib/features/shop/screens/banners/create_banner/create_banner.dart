import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/create_banner/responsive_screens/create_banner_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/create_banner/responsive_screens/create_banner_mobile.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/create_banner/responsive_screens/create_banner_tablet.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CreateBannerDesktopScreen(),
    );
  }
}
