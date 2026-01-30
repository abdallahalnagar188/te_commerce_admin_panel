import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../common/widgets/safe_network_image.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    this.onTapToAddImages,
    this.onTapToRemoveImage,
  });

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
                  ),
                ),
              ),
            ),
          ),

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
                const SizedBox(width: TSizes.spaceBtwItems / 2),

                // Add More Images Button
                TRoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: TColors.grey,
                  backgroundColor: TColors.white,
                  onTap: onTapToAddImages,
                  child: const Center(child: Icon(Iconsax.add)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadedImagesOrEmptyList() {
    return Obx(() {
      if (additionalProductImagesURLs.isEmpty) {
        return emptyList();
      } else {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: additionalProductImagesURLs.length,
          separatorBuilder: (context, index) =>
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          itemBuilder: (context, index) {
            final imageUrl = additionalProductImagesURLs[index];
            return Stack(
              children: [
                TRoundedContainer(
                  backgroundColor: TColors.primaryBackground,
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SafeNetworkImage(
                      url: imageUrl,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),

                // Remove Button
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      if (index >= 0 &&
                          index < additionalProductImagesURLs.length) {
                        onTapToRemoveImage?.call(index);
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Widget emptyList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 1, // just 1 placeholder box
      itemBuilder: (context, index) => const TRoundedContainer(
        backgroundColor: TColors.primaryBackground,
        width: 80,
        height: 80,
      ),
      separatorBuilder: (context, index) =>
      const SizedBox(width: TSizes.spaceBtwItems / 2),
    );
  }
}
