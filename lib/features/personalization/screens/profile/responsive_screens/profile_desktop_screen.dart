import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/personalization/screens/profile/widget/profile_form.dart';
import 'package:te_commerce_admin_panel/features/personalization/screens/profile/widget/image_meta.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../utils/constants/sizes.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                  heading: 'Profile', breadcrumbsItems: ['Profile']),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(child: ImageMeta()),
                  SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),
                  // Form
                  Expanded(child: ProfileForm()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
