import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/category/edit_category/widgets/edit_category_form.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../brands/edit_brand/widgets/edit_brand_form.dart';

class EditCategoryDesktopScreen extends StatelessWidget {
  const EditCategoryDesktopScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(heading: 'Update Category', breadcrumbsItems: [TRoutes.categories,'update category'],returnToPreviousScreen: true,),
              SizedBox(height: TSizes.spaceBtwSections,),

              EditCategoryForm(category: category,)
            ],
          ),
        ),
      ),
    );;
  }
}
