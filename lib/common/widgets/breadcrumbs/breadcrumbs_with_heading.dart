import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/texts/page_heading.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

class TBreadcrumbsWithHeading extends StatelessWidget {
  const TBreadcrumbsWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbsItems,
     this.returnToPreviousScreen =false
  }
  );

  final String heading;
  final List<String> breadcrumbsItems;
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Dashboard link
            InkWell(
              onTap: () => Get.offAllNamed(TRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),

            // Loop through breadcrumbs
            for (int i = 0; i < breadcrumbsItems.length; i++) ...[
              const Text(' / '),
              InkWell(
                onTap: i == breadcrumbsItems.length - 1
                    ? null
                    : () => Get.offAllNamed(breadcrumbsItems[i]),
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.xs),
                  child: Text(
                    i == breadcrumbsItems.length - 1
                        ? breadcrumbsItems[i].capitalize.toString()
                        : capitalize(breadcrumbsItems[i].substring(1)),
                    style: Theme.of(context).textTheme.bodySmall!.apply(
                      fontWeightDelta: -1,
                      color: i == breadcrumbsItems.length - 1
                          ? Colors.grey // last item is not clickable
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),


        SizedBox(height: TSizes.sm,),
        //Heading of the page

        Row(
          children: [
            if(returnToPreviousScreen) IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            if(returnToPreviousScreen) const SizedBox(width: TSizes.spaceBtwItems,),
            TPageHeading(heading: heading)
          ],
        )
      ],
    );
  }

  String capitalize (String s){
    return s.isEmpty ? '' : s[0].toUpperCase() +s.substring(1);
  }
}
