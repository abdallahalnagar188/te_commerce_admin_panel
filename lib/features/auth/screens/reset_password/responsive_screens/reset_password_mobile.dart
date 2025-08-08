import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/features/auth/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

class ResetPasswordScreenMobile extends StatelessWidget {
  const ResetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: ResetPasswordWidget(email: email),
        ),
      ),
    );
  }
}
