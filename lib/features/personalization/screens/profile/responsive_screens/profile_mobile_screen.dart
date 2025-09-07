import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(heading: 'Profile', breadcrumbsItems: ['Profile']),
              SizedBox(height: TSizes.spaceBtwSections,),

            ],
          ),
        ),
      ),
    );
  }
}
