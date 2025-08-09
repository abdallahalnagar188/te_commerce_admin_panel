import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:te_commerce_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../widgets/dashboard_card.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Cards
            Row(
              children: [
                Expanded(child: TDashboardCard(title: 'Sales Total', subTitle: '\$356.6', stats: 25,)),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Expanded(child: TDashboardCard(title: 'Average Order Value', subTitle: '\$25.6', stats: 15,)),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Expanded(child: TDashboardCard(title: 'Total Orders', subTitle: '\$35', stats: 44,)),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Expanded(child: TDashboardCard(title: 'Visitors', subTitle: '254,034', stats: 2,)),
                const SizedBox(width: TSizes.spaceBtwItems,),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
