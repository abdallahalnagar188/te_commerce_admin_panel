import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/customer_order_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Orders', style: Theme.of(context).textTheme.headlineMedium),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Total Spent '),
                    TextSpan(
                        text: '\$500.35',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary)
                    ),
                    TextSpan(
                        text: ' on ${5} Orders',
                        style: Theme.of(context).textTheme.bodyLarge
                    ),
                  ],
                ),
              ), // Text.rich
            ],
          ), // Row
          const SizedBox(height: TSizes.spaceBtwItems),
          TextFormField(
            onChanged: (query) {},
            decoration: const InputDecoration(
                hintText: 'Search Orders',
                prefixIcon: Icon(Iconsax.search_normal)
            ),
          ), // TextFormField
          const SizedBox(height: TSizes.spaceBtwSections),
          const CustomerOrderTable(),
        ],
      ), // Column
    ); // TRoundedContainer
  }
}