import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/login/responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: LoginScreenDesktopTablet(),
      mobile: LoginScreenMobile(),
    );
  }
}
