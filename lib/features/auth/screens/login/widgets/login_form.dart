
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(

        children: [
          /// Email
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields,),

          /// Password
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(onPressed: (){}, icon: Icon(Iconsax.eye_slash)),
                labelText: TTexts.password
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields /2),

          /// Remember me and Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// remember me
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(value: true, onChanged: (value){}),
                  Text(TTexts.rememberMe)
                ],
              ),
              /// forget password
              TextButton(onPressed: (){}, child: Text(TTexts.forgetPassword))
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// Sign in button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: (){}, child: Text(TTexts.signIn)),
          )

        ],
      ),
    ));
  }
}