import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/create_brand/widgets/create_brand_form.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/category/create_category/widgets/create_category_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateBrandDesktopScreen extends StatelessWidget {
  const CreateBrandDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(heading: 'Create Brand', breadcrumbsItems: [TRoutes.brands,'create brand'],returnToPreviousScreen: true,),
              SizedBox(height: TSizes.spaceBtwSections,),

              CreateBrandForm()
            ],
          ),
        ),
      ),
    );
  }
}
