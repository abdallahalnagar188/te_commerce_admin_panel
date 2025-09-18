import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/product_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../controllers/product/edit_product_controller.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Discard')),
          SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),
          SizedBox(
            width: 160,
            child: ElevatedButton(
                onPressed: () => EditProductController.instance.updateProduct(product),
                child: Text('Save Changes')),
          )
        ],
      ),
    );
  }
}
