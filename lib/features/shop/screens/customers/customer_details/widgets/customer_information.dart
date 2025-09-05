import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../auth/models/user_model.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
    required this.customer,
  });

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              'Customer Information',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Personal Info Card
            Row(
              children: [
                /// Customer Avatar
                const TRoundedImage(
                  padding: 0,
                  backgroundColor: TColors.primaryBackground,
                  image: TImages.user,
                  imageType: ImageType.asset,
                ),

                const SizedBox(width: TSizes.spaceBtwItems),

                /// Customer Name & Email
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.fullName,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        customer.email,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// TODO: You can add more sections like address, phone number, etc.
            /// Username
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Username')),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    'abdallah',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Country
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Country')),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    'United Kingdom',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Phone Number
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Phone Number')),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    '+44-7456-285429',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Divider
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Additional Details (placeholder for more info)
            Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Order',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('7 Days Ago , #[78dhi]')
                  ],
                )),
                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Average Order value',style: Theme.of(context).textTheme.titleLarge,),
                    const Text('\$788')
                  ],
                ))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems,),

            Row(
              children: [
                Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Registered',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                         Text(customer.formattedDate)
                      ],
                    )),
                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Marketing',style: Theme.of(context).textTheme.titleLarge,),
                    const Text('Subscribed')
                  ],
                ))
              ],
            ),
          ],
        ));
  }
}
