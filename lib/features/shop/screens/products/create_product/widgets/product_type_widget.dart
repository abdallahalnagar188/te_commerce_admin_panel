
import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Product Type',style: Theme.of(context).textTheme.bodyMedium,),
        const SizedBox(width: TSizes.spaceBtwItems,),

        RadioMenuButton(
          value: ProductType.single,
          groupValue: ProductType.single,
          onChanged: (value){},
          child: const Text('Single'),
        ),
        RadioMenuButton(
          value: ProductType.variable,
          groupValue: ProductType.single,
          onChanged: (value){},
          child: const Text('Variable'),
        ),
      ],
    ) ;
  }
}
