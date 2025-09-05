import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages(
      {super.key,
      required this.additionalProductImagesURLs,
      this.onTapToAddImages,
      this.onTapToRemoveImage});

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          // Section to Add Additional Product Images
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTapToAddImages,
              child: TRoundedContainer(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                       TImages.defaultImage,
                        width: 50,
                        height: 50,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Add Additional Product Images',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ), // Column
                ), // Center
              ), // TRoundedContainer
            ),
          ), // GestureDetector

          const SizedBox(height: 16),

          // Section to Display Uploaded Images
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 80,
                    child: _uploadedImagesOrEmptyList(),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),

                // Add More Images Button
                TRoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: TColors.grey,
                  backgroundColor: TColors.white,
                  onTap: onTapToAddImages,
                  child: Center(child: Icon(Iconsax.add)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadedImagesOrEmptyList() {
    return emptyList();
  }

  Widget emptyList() {
    return ListView.separated(
        itemBuilder: (context, index) => const TRoundedContainer(backgroundColor: TColors.primaryBackground, width: 80, height: 80,),
        separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems / 2,),
        itemCount: 6);
  }
}
