import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/brands/create_brand/widgets/create_brand_form.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/create_banner_form.dart';

class CreateBannerDesktopScreen extends StatelessWidget {
  const CreateBannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(heading: 'Create Banner', breadcrumbsItems: [TRoutes.banners,'create banner'],returnToPreviousScreen: true,),
              SizedBox(height: TSizes.spaceBtwSections,),

              CreateBannerForm()
            ],
          ),
        ),
      ),
    );
  }
}
