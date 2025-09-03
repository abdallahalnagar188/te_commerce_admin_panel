import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

import '../../../../../../common/widgets/chips/rounded_choice_chips.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Heading
              const SizedBox(height: TSizes.sm,),
              Text('Edit Brand', style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              // Name Text Field
              TextFormField(
                validator: (value) => TValidator.validateEmptyText('Name', value),
                decoration: InputDecoration(labelText: 'Brand name', prefixIcon: Icon(Iconsax.box)),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields * 2,),

              // Categories
              Text('Select Categories',style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2,),
              Wrap(
                spacing: TSizes.sm,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: TSizes.sm),
                    child: TChoiceChip(text: 'Shoes', selected: true,onSelected: (value){},),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: TSizes.sm),
                    child: TChoiceChip(text: 'Track Suits', selected: false,onSelected: (value){},),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2,),

              TImageUploader(imageType: ImageType.asset,width: 80,height: 80,image: TImages.defaultImage,onIconButtonPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2,),

              CheckboxMenuButton(value: true, onChanged: (value){}, child: const Text('Featured')),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2,),

              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: Text('Update')),),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2,),


            ],
          )),
    );
  }
}
