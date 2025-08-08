import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/reset_password/responsive_screens/reset_password_mobile.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: ResetPasswordScreenDesktopTablet(),
      mobile: ResetPasswordScreenMobile(),
    );
  }
}
