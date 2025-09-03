import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../table/data_table.dart';

class BannersDesktopScreen extends StatelessWidget {
  const BannersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBreadcrumbsWithHeading(heading: 'Banners', breadcrumbsItems: ['Banners']),
            SizedBox(height: TSizes.spaceBtwSections,),
            TRoundedContainer(
              height: 500,
              child: Column(
                children: [
                  TTableHeader(
                    buttonText: 'Create New Banner',
                    onPressed: () => Get.toNamed(TRoutes.createBanner),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Expanded(child: BannersTable()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
