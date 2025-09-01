import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controller/media_controller.dart';
import 'folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Image Header
          Row(
            children: [
              // Folders Dropdown
              Text(
                'Select Folder',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                  }
                },
              ),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwSections,),

          /// Show Media
          Wrap(
            alignment: WrapAlignment.start,
            spacing: TSizes.spaceBtwItems / 2,
            runSpacing: TSizes.spaceBtwItems / 2,
            children: [
              TRoundedImage(
                imageType: ImageType.asset,
                width: 90,
                height: 90,
                padding: TSizes.sm,
                image: TImages.darkAppLogo,
                backgroundColor: TColors.primaryBackground,
              ),
              TRoundedImage(
                imageType: ImageType.asset,
                width: 90,
                height: 90,
                padding: TSizes.sm,
                image: TImages.darkAppLogo,
                backgroundColor: TColors.primaryBackground,
              ),  TRoundedImage(
                imageType: ImageType.asset,
                width: 90,
                height: 90,
                padding: TSizes.sm,
                image: TImages.darkAppLogo,
                backgroundColor: TColors.primaryBackground,
              ),  TRoundedImage(
                imageType: ImageType.asset,
                width: 90,
                height: 90,
                padding: TSizes.sm,
                image: TImages.darkAppLogo,
                backgroundColor: TColors.primaryBackground,
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems,),

          /// Load More Media Button
          Padding(padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: TSizes.buttonWidth,
                child: ElevatedButton.icon(onPressed: (){}, label: Text('Load More'),icon: Icon(Iconsax.arrow_down),),
              )
            ],
          ),)
        ],
      ),
    );
  }
}
