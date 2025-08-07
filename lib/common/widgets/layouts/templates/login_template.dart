import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/styles/spacing_styles.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/constants/text_strings.dart';


class TLoginTemplate extends StatelessWidget {
  const TLoginTemplate({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
                color: TColors.white,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLg)
            ),

            child: child,
          ),
        ),
      ),
    );
  }
}


