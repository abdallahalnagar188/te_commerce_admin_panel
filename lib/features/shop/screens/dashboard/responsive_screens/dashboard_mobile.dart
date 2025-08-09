import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge,),
                const SizedBox(height: TSizes.spaceBtwSections,),

                // Cards
                TDashboardCard(title: 'Sales Total', subTitle: '\$356.6', stats: 25,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                TDashboardCard(title: 'Average Order Value', subTitle: '\$25.6', stats: 15,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                TDashboardCard(title: 'Total Orders', subTitle: '\$35', stats: 44,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                TDashboardCard(title: 'Visitors', subTitle: '254,034', stats: 2,),
              ],
            ),
          ),
        )
    );
  }
}
