import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stock
          FractionallySizedBox(
            widthFactor: 0.45,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Stock',
                hintText: 'Add Stock, only numbers are allowed',
              ),
              validator: (value) =>
                  TValidator.validateEmptyText('Stock', value),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ), // FractionallySizedBox

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Pricing
          Row(
            children: [
             Expanded(child: TextFormField(
               decoration: const InputDecoration(labelText: 'Price', hintText: 'price with up to 2 decimals',),
               validator: (value) => TValidator.validateEmptyText('Price', value),
               keyboardType: const TextInputType.numberWithOptions(decimal: true),
               inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
               ],
             )),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(child: TextFormField(
                decoration: const InputDecoration(labelText: 'Discounted Price', hintText: 'price with up to 2 decimals',),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
