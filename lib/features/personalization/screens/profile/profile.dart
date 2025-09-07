import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/features/personalization/screens/profile/responsive_screens/profile_desktop_screen.dart';
import 'package:te_commerce_admin_panel/features/personalization/screens/profile/responsive_screens/profile_mobile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop:ProfileDesktopScreen(),mobile: ProfileMobileScreen(),);
  }
}
