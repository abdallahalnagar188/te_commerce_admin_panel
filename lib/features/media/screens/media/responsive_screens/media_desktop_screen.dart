import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:te_commerce_admin_panel/features/media/screens/media/widgets/mdia_content.dart';
import 'package:te_commerce_admin_panel/features/media/screens/media/widgets/media_uploader.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../controller/media_controller.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TBreadcrumbsWithHeading(
                    breadcrumbsItems: [TRoutes.login, TRoutes.forgetPassword],
                    heading: 'Media Screen',
                  ),

                  SizedBox(width : 170,child: ElevatedButton.icon(onPressed: () => controller.showImageUploaderSection.value = !controller.showImageUploaderSection.value, label: const Text('Upload Images',), icon: const Icon(Iconsax.cloud_add),))
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Upload Area
              const MediaUploader(),

              /// Media
              const MediaContent()
            ],
          ),
        ),
      ),
    );
  }
}
