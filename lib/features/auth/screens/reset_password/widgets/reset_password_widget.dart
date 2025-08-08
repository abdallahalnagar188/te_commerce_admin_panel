
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: () => Get.offAllNamed(TRoutes.login), icon: Icon(CupertinoIcons.clear)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),

        /// Image
        Image(image: AssetImage(TImages.deliveredEmailIllustration),width: 300,height: 300,),
        const SizedBox(height: TSizes.spaceBtwItems,),

        /// Title and subTitle
        Text(TTexts.changeYourPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(email,style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(TTexts.changeYourPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwSections,),

        /// Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.offAllNamed(TRoutes.login),
              child: Text(TTexts.done)),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () => Get.back(),
              child: Text(TTexts.resendEmail)),
        ),


      ],
    );
  }
}