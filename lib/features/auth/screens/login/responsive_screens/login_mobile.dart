import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Header
              TLoginHeader(),

              // Form
              TLoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
