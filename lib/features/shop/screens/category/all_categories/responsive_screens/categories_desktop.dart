import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/category/all_categories/table/data_table.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

class CategoriesDesktopScreen extends StatelessWidget {
  const CategoriesDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBreadcrumbsWithHeading(
                heading: 'Categories', breadcrumbsItems: ['Categories']),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TRoundedContainer(
              height: 500,
              child: Column(
                children: [
                  TTableHeader(
                    buttonText: 'Create New Category',
                    onPressed: () => Get.toNamed(TRoutes.createCategory),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Expanded(child: CategoryTable()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
