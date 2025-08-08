import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/forget_password/widgets/header_form.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

class ForgetPasswordScreenMobile extends StatelessWidget {
  const ForgetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: HeaderAndForm(),
        ),
      ),
    );
  }
}
