import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banner_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banner_mobile.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banner_tablet.dart';


class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: BannersDesktopScreen());
  }
}
