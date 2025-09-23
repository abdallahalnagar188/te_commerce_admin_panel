import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../controllers/customer/customer_details_controller.dart';
import '../../../../models/address_model.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddress();

    return Obx(() {
      if (controller.addressesLoading.value) {
        return const TLoaderAnimation();
      }

      AddressModel selectedAddress = AddressModel.empty();

      if (controller.customer.value.addresses != null &&
          controller.customer.value.addresses!.isNotEmpty) {
        selectedAddress = controller.customer.value.addresses!.firstWhere(
              (element) => element.selectedAddress,
          orElse: () => AddressModel.empty(),
        );
      }

      return TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              'Address',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Meta Data - Name
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Name')),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Meta Data - Country
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Country')),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.country,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Meta Data - Phone Number
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Phone Number')),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.phoneNumber,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Meta Data - Address
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Address')),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.id.isNotEmpty
                        ? selectedAddress.toString()
                        : '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
