import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/edit_brand/widgets/edit_brand_form.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/category/edit_category/widgets/edit_category_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key, required this.brand});

  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(heading: 'Update Brand', breadcrumbsItems: [TRoutes.categories,'update brand'],returnToPreviousScreen: true,),
              SizedBox(height: TSizes.spaceBtwSections,),

              EditBrandForm(brand: brand,)
            ],
          ),
        ),
      ),
    );
  }
}
