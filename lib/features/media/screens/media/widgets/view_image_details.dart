import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/features/media/controller/media_controller.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../models/image/image_model.dart';

class ImagePopup extends StatelessWidget {
  /// The image model to display detailed information about.
  final ImageModel image;

  // Constructor for the ImagePopup class.
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: TRoundedContainer(
          // Set the width of the rounded container based on the screen size.
          width: TDeviceUtils.isDesktopScreen(context)
              ? MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Display the image with an option to close the dialog.
              SizedBox(
                child: Stack(
                  children: [
                    /// Display the image with rounded container.
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        image: image.url!,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: TDeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.of(context).size.width * 0.4
                            : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ),

                    /// Close button positioned at the top-right corner.
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Iconsax.close_circle),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                children: [
                  Text(
                    'Image Name:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: TSizes.spaceBtwSections * 2.1),
                  Text(
                    image.fileName!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Display the image URL with an option to copy it.
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image URL:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      image.url!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url!).then(
                          (value) => TLoaders.customToast(
                            message: 'URL copied!',
                          ),
                        );
                      },
                      child: Text(
                        'Copy URL',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Display a button to delete the image.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context) ? null : 300,
                    child: TextButton(
                      onPressed: () => MediaController.instance
                          .removeCloudImageConfirmation(image),
                      child: const Text(
                        'Delete Image',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),

              // You can add more widgets below (like image details, metadata, etc.)
            ],
          ),
        ),
      ),
    );
  }
}
