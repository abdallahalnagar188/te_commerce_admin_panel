
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controllers/product/create_product_controller.dart';
import '../../../../controllers/product/edit_product_controller.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;
    return Obx(
      () => Row(
        children: [
          Text('Product Type',style: Theme.of(context).textTheme.bodyMedium,),
          const SizedBox(width: TSizes.spaceBtwItems,),

          RadioMenuButton(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) => controller.productType.value = value ?? ProductType.single,
            child: const Text('Single'),
          ),
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value)=> controller.productType.value = value ?? ProductType.variable,
            child: const Text('Variable'),
          ),
        ],
      ),
    ) ;
  }
}
