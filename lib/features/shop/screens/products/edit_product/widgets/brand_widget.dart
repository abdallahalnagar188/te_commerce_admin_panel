import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/safe_network_image.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final brandController = Get.put(BrandController());

    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Label
          Text(
            'Brand',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // TypeAheadField for brand selection
          Obx(
                () => brandController.isLoading.value
                ? const TShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(
              builder: (context, textController, focusNode) {
                return TextFormField(
                  controller: controller.brandTextField,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Brand',
                    suffixIcon: Icon(Iconsax.box),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                // Return filtered brand suggestions based on the search pattern
                return brandController.allItems
                    .where((brand) =>
                    brand.name.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: SafeNetworkImage(
                    url: suggestion.image,
                    width: 30,
                    height: 30,
                    placeholder: const Icon(Icons.business),
                  ),
                  title: Text(suggestion.name),
                );
              },
              onSelected: (suggestion) {
                // Handle brand selection
                controller.selectedBrand.value = suggestion;
                controller.brandTextField.text = suggestion.name;
                debugPrint("Selected brand: ${suggestion.name}");
              },
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Show Selected Brand (Reactive with Obx)
          Obx(() {
            final selectedBrand = controller.selectedBrand.value;
            if (selectedBrand == null) {
              return const SizedBox(); // nothing if not selected
            }
            return Row(
              children: [
                SafeNetworkImage(
                  url: selectedBrand.image,
                  width: 40,
                  height: 40,
                  placeholder: const Icon(Icons.business),
                ),
                const SizedBox(width: 8),
                Text(
                  selectedBrand.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}