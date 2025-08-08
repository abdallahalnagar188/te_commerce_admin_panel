import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/forget_password/responsive_screens/forget_password_mobile.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: ForgetPasswordScreenDesktopTablet(),
      mobile: ForgetPasswordScreenMobile(),
    );
  }
}
