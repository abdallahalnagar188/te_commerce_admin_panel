import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/order/order_details_controller.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/order_model.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Obx(() {
                return Row(
                  children: [
                     TRoundedImage(
                      padding: 0,
                      backgroundColor: TColors.primaryBackground,
                      image: controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture : TImages.defaultImage,
                      imageType:  controller.customer.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.customer.value.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                           Text(
                          controller.customer.value.email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Contact Info
        Obx(
    () =>  SizedBox(
            width: double.infinity,
            child: TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Person', style: Theme.of(context).textTheme.headlineMedium,),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  Text(controller.customer.value.fullName, style: Theme.of(context).textTheme.titleSmall,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2,),
                  Text(controller.customer.value.email, style: Theme.of(context).textTheme.titleSmall,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2,),
                  Text(controller.customer.value.formattedPhoneNo, style: Theme.of(context).textTheme.titleSmall,),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        // Adjust as per your needs
        // Contact Info
   SizedBox(
            width: double.infinity,
            child: TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shipping Address',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(order.shippingAddress != null ? order.shippingAddress!.name : '',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text( order.shippingAddress != null ? order.shippingAddress!.toString() : '',
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ), // Column
            ), // TRoundedContainer
          ),
        const SizedBox(height: TSizes.spaceBtwSections),

        SizedBox(
            width: double.infinity,
            child: TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Billing Address',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(order.billingAddress != null ? order.billingAddress!.name : '',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(order.billingAddress != null ? order.billingAddress!.toString() : '',
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
          ),


        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
