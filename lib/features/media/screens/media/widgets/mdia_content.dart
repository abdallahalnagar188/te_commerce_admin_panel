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
  MediaContent(
      {super.key,
      required this.allowSelection,
      required this.allowMultipleSelection,
      this.alreadySelectedUrls,
      this.onImagesSelected});

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = MediaController.instance;

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Image Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Folders Dropdown
                  Text('Select Folder', style: Theme.of(context).textTheme.headlineSmall,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
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
              if (allowSelection) buildAddSelectedImagesButton()
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          /// Show Media
          Obx(() {
            // get Selected Folder Images
            List<ImageModel> images = _getSelectedFolderImages(controller);

            if (!loadedPreviousSelection) {
              if (alreadySelectedUrls != null &&
                  alreadySelectedUrls!.isNotEmpty) {
                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);
                for (var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
            }

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
                                  allowSelection
                                      ? _buildListWithCheckBox(image)
                                      : _buildSimpleList(image),
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
        text: 'Select your Desired Folder',
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

  Widget _buildListWithCheckBox(ImageModel image) {
    return Stack(
      children: [
        TRoundedImage(
          imageType: ImageType.network,
          width: 140,
          height: 140,
          padding: TSizes.sm,
          image: image.url,
          margin: TSizes.spaceBtwItems / 2,
          backgroundColor: TColors.primaryBackground,
        ),
        Positioned(
            top: TSizes.md,
            right: TSizes.md,
            child: Obx(() => Checkbox(
                value: image.isSelected.value,
                onChanged: (selected) {
                  if (selected != null) {
                    image.isSelected.value = selected;
                    if (selected) {
                      if (!allowMultipleSelection) {
                        for (var otherImage in selectedImages) {
                          if (otherImage != image) {
                            otherImage.isSelected.value = false;
                          }
                        }
                      }
                      selectedImages.add(image);
                    } else {
                      selectedImages.remove(image);
                    }
                  }
                })))
      ],
    );
  }

  Widget buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            label: Text('Close'),
            icon: Icon(Iconsax.close_circle),
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: selectedImages),
            label: Text('Add'),
            icon: Icon(Iconsax.image),
          ),
        ),
      ],
    );
  }
}
