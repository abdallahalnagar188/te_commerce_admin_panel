import 'dart:io' as html;

import 'package:universal_html/html.dart';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:te_commerce_admin_panel/features/media/controller/media_controller.dart';
import 'package:te_commerce_admin_panel/features/media/screens/media/widgets/folder_dropdown.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';
import '../../../models/image/image_model.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImageUploaderSection.value
          ? Column(
              children: [
                /// Drag and Drop Area
                TRoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        alignment: Alignment.center,
                        children: [
                          DropzoneView(
                            mime: ['image/jpeg', 'image/png'],
                            cursor: CursorType.Default,
                            operation: DragOperation.copy,
                            onLoaded: () => print('Zone loaded'),
                            onError: (ev) => print('Zone Error $ev'),
                            onHover: () => print('Zone Hovered'),
                            onLeave: () => print('Zone left'),
                            onCreated: (ctrl) =>
                                controller.dropzoneViewController = ctrl,
                            onDropInvalid: (ev) =>
                                print('Zone invalid MIME $ev'),
                            onDropMultiple: (ev) =>
                                print('Zone drop multiple $ev'),
                            onDrop: (file) async {
                              if (file) {
                                final bytes = await controller
                                    .dropzoneViewController
                                    .getFileData(file);
                                final image = ImageModel(
                                  url: '',
                                  file: file,
                                  // Cast to expected type
                                  folder: '',
                                  fileName: file.name,
                                  localImageToDisplay:
                                      Uint8List.fromList(bytes),
                                );
                                controller.selectedImagesToUpload.add(image);
                              } else if (file is String) {
                                print('Zone drop: $file');
                              } else
                                print('Unknown type');
                            },
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                TImages.defaultMultiImageIcon,
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: TSizes.spaceBtwItems,
                              ),
                              const Text('Drag and Drop Image here'),
                              SizedBox(
                                height: TSizes.spaceBtwItems,
                              ),
                              OutlinedButton(
                                  onPressed: () => controller.selectLocalImage(),
                                  child: const Text('Select Image'))
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                /// Locally Selected Images
                if (controller.selectedImagesToUpload.isNotEmpty)
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Folders Dropdown
                                Text(
                                  'Select Folder',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
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
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () => controller.selectedImagesToUpload.clear(),
                                    child: Text('Remove All')),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                TDeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                            onPressed: () => controller.uploadImagesConfirmation(),
                                            child: Text('Upload')),
                                      )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: TSizes.spaceBtwItems / 2,
                          runSpacing: TSizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload.where((image) => image.localImageToDisplay != null).map((element) => TRoundedImage(
                            width: 90,
                            height: 90,
                            padding: TSizes.sm,
                            imageType: ImageType.memory,
                            memoryImage: element.localImageToDisplay,
                            backgroundColor: TColors.primaryBackground,
                          )).toList(),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        TDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () => controller.uploadImagesConfirmation(), child: Text('Upload')),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
