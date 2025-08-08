
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        IconButton(icon: Icon(Iconsax.arrow_left), onPressed: () => Get.back()),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwItems * 2),

        /// Form
        Form(
          child: TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        /// Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.toNamed(TRoutes.resetPassword,
                  parameters: {'email': 'abdallah@gmail.com'}),
              child: Text(TTexts.submit)),
        )
      ],
    );
  }
}