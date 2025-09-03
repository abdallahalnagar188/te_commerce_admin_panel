import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brand_desktop.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brand_mobile.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brand_tablet.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: BrandsDesktopScreen(),tablet: BrandsTabletScreen(),mobile: BrandsMobileScreen(),);
  }
}
