import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Settings
        TRoundedContainer(
          padding: EdgeInsets.symmetric(vertical: TSizes.lg,horizontal: TSizes.md),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings',style: Theme.of(context).textTheme.headlineSmall,),
                const SizedBox(height: TSizes.spaceBtwSections,),

                // App Name
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'App Name',
                      labelText: 'App Name',
                      prefixIcon: Icon(Iconsax.user)
                    ),
                  ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                Row(
                  spacing: TSizes.md,
                  children: [
                    Expanded(child: TextFormField(decoration: const InputDecoration(hintText: 'Tax %', labelText: 'Tax Rate (%)', prefixIcon: Icon(Iconsax.user)))),
                    Expanded(child: TextFormField(decoration: const InputDecoration(hintText: 'Shipping \$', labelText: 'Shipping Coast (\$)', prefixIcon: Icon(Iconsax.user)))),
                    Expanded(child: TextFormField(decoration: const InputDecoration(hintText: 'Shipping \$', labelText: 'Free Shipping After(\$)', prefixIcon: Icon(Iconsax.user)))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),

                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: Text('Update App Settings')),)
              ],
            ),
          ),
        )
      ],
    );
  }
}
