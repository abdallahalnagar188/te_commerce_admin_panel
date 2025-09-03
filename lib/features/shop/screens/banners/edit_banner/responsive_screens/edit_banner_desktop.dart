import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/edit_brand/widgets/edit_brand_form.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/category/edit_category/widgets/edit_category_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/edit_banner_form.dart';

class EditBannerDesktopScreen extends StatelessWidget {
  const EditBannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(heading: 'Update Banner', breadcrumbsItems: [TRoutes.categories,'update banner'],returnToPreviousScreen: true,),
              SizedBox(height: TSizes.spaceBtwSections,),

              EditBannerForm()
            ],
          ),
        ),
      ),
    );
  }
}
