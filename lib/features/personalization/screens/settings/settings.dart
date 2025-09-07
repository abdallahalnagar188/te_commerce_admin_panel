import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/personalization/screens/settings/responsive_screens/settings_desktop_screen.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop:SettingsDesktopScreen());
  }
}
