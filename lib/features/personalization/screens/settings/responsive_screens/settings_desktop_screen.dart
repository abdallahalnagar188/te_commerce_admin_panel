import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/features/personalization/screens/profile/widget/profile_form.dart';
import 'package:te_commerce_admin_panel/features/personalization/screens/settings/widget/image_meta_settings.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widget/settings_form.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

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
                  heading: 'Settings', breadcrumbsItems: ['Settings']),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(child: ImageMetaSettings()),
                  SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),
                  // Form
                  Expanded(child: SettingsForm()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
