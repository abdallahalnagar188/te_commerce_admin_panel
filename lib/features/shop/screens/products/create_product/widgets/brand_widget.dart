import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../data/repos/shop/brand_model.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Label
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems), // Using a fixed value instead of TSizes.spaceBtnItems

          // TypeAheadField for brand selection
          TypeAheadField(
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Brand',
                  suffixIcon: Icon(Iconsax.box),
                ), // InputDecoration
              ); // TextFormField
            },
            suggestionsCallback: (pattern) {
              // Return filtered brand suggestions based on the search pattern
              return [
                BrandModel(id: '1', image: TImages.adidasLogo, name: 'Adidas'),
                BrandModel(id: '2', image: TImages.nikeLogo, name: 'Nike'),
                BrandModel(id: '3', image: TImages.pumaLogo, name: 'Puma'),
                BrandModel(id: '4', image: TImages.zaraLogo, name: 'Zara'),
              ].where((brand) =>
                  brand.name.toLowerCase().contains(pattern.toLowerCase())
              ).toList();
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Image.asset(
                  suggestion.image,
                  width: 30,
                  height: 30,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.business);
                  },
                ),
                title: Text(suggestion.name),
              );
            },
            onSelected: (suggestion) {
              // Handle brand selection
              debugPrint("Selected brand: ${suggestion.name}");
            },
          ), // TypeAheadField
        ],
      ), // Column
    ); // TRoundedContainer
  }
}