import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:te_commerce_admin_panel/features/media/models/image/image_model.dart';
import 'package:te_commerce_admin_panel/features/media/screens/media/widgets/view_image_details.dart';
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
                    controller.getMediaImages();
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          /// Show Media
          Obx(() {
            // get Selected Folder Images
            List<ImageModel> images = _getSelectedFolderImages(controller);

            // Loader
            if (controller.loading.value && images.isEmpty) {
              return const TLoaderAnimation();
            }

            // Empty Widget
            if (images.isEmpty) {
              return _buildEmptyAnimationWidget(context);
            }

            return Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: TSizes.spaceBtwItems / 2,
                  runSpacing: TSizes.spaceBtwItems / 2,
                  children: images
                      .map((image) => GestureDetector(
                            onTap: () => Get.dialog(ImagePopup(image: image)),
                            child: SizedBox(
                              width: 140,
                              height: 180,
                              child: Column(
                                children: [
                                  _buildSimpleList(image),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: TSizes.sm),
                                    child: Text(
                                      image.fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                /// Load More Media Button
                if (!controller.loading.value)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: TSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreMediaImages(),
                            label: Text('Load More'),
                            icon: Icon(Iconsax.arrow_down),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];

    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }

    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        text: 'Select your Desried Folder',
        animation: TImages.packageAnimation,
        width: 300,
        height: 300,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      imageType: ImageType.network,
      width: 140,
      height: 140,
      padding: TSizes.sm,
      image: image.url,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }
}
