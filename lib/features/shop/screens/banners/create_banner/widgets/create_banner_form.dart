import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

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
          const SizedBox(
            height: TSizes.sm,
          ),
          Text(
            'Create New Banner',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          Column(
            children: [
              GestureDetector(
                child: const TRoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: TColors.primaryBackground,
                    image: TImages.defaultImage,
                    imageType: ImageType.asset),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextButton(onPressed: () {}, child: Text('Select Image'))
            ],
          ),

          Text('Make your Banner Active or InActive', style: Theme.of(context).textTheme.bodyMedium,),

          CheckboxMenuButton(value: true, onChanged: (value) {}, child: const Text('Active'),),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Dropdown Menu Screens
          DropdownButton<String>(value: 'search', onChanged: (String? newValue) {}, items: const [
              DropdownMenuItem<String>(value: 'home', child: Text('Home'),),
              DropdownMenuItem<String>(value: 'search',child: Text('Search'),),
            ],
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text('Create')),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields * 2,),
        ],
      )),
    );
  }
}
