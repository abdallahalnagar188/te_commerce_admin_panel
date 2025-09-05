import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(onPressed: () {}, child: Text('Discard')),
          SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),
          SizedBox(
            width: 160,
            child:
                ElevatedButton(onPressed: () {}, child: Text('Save Changes')),
          )
        ],
      ),
    );
  }
}
