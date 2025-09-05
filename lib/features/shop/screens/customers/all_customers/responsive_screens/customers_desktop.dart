import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../table/data_table.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading + Breadcrumbs
              const TBreadcrumbsWithHeading(
                heading: 'Customers',
                breadcrumbsItems: ['Customers'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Responsive expandable content
              Expanded(
                child: TRoundedContainer(
                  // Instead of fixed height: make it fill available height
                  child: Column(
                    children: [
                      const TTableHeader(showLeftWidget: false),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Make table take the rest of available height
                      Expanded(child: CustomersTable()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
