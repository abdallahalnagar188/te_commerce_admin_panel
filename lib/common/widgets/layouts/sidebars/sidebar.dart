import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import 'menu/menu_item.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
            color: TColors.white,
            border: Border(right: BorderSide(color: TColors.grey, width: 1))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Padding(
                padding: EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MENU',style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),

                    // Menu Items
                    TMenuItem(icon: Iconsax.status,itemName: 'Dashboard',route:'',),
                    TMenuItem(icon: Iconsax.image,itemName: 'Media',route: '',),
                    TMenuItem(icon: Iconsax.picture_frame,itemName: 'Banners',route: '',),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

