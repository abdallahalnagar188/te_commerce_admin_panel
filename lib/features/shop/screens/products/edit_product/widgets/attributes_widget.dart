import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:te_commerce_admin_panel/utils/validators/validation.dart';

import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/product/product_attributes_controller.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductAttributesController());
    final productController = Get.put(ProductController());
    final variationController = Get.put(ProductVariationsController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: TColors.primaryBackground),
        const SizedBox(height: TSizes.spaceBtwSections),

        Text(
          'Add Product Attributes',
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Form to add new attribute
        Form(
          key: controller.attributesFormKey,
          child: TDeviceUtils.isDesktopScreen(context)
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildAttributeName(controller),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                flex: 2,
                child: _buildAttributeTextField(controller),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              _buildAddAttributeButton(controller),
            ],
          )
              : Column(
            children: [
              _buildAttributeName(controller),
              const SizedBox(height: TSizes.spaceBtwItems),
              _buildAttributeTextField(controller),
              const SizedBox(height: TSizes.spaceBtwItems),
              _buildAddAttributeButton(controller),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections,),

        // List of added Attributes
        Text('All Attributes', style: Theme
            .of(context)
            .textTheme
            .headlineSmall,),
        const SizedBox(height: TSizes.spaceBtwItems,),

        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Obx(
                () => controller.productAttributes.isNotEmpty?
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.productAttributes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: TColors.white,
                        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                      ),
                      child: ListTile(
                        title:  Text(controller.productAttributes[index].name ?? ''),
                        subtitle:  Text(controller.productAttributes[index].values!.map((e) => e.trim()).toString()),
                        trailing: IconButton(
                          onPressed: () => controller.removeAttribute(index, context),
                          icon: const Icon(Iconsax.trash, color: TColors.error),
                        ),
                      ),
                    );
                  },
                ) :const Column(
                  children: [
                    Row(
                      children: [
                        TRoundedImage(
                          width: 150,
                          height: 80,
                          imageType: ImageType.asset,
                          image: TImages.defaultAttributeColorsImageIcon,
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Text('There are no attributes added for this product'),
                  ],
                ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),

        // Variation Button
        Obx(
        () => controller.productAttributes.isEmpty && productController.productType.value == ProductType.variable?  Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(onPressed: () => variationController.generateVariationsConfirmation(context),
                label: Text('Generate Variation'),
                icon: Icon(Iconsax.activity),),
            ),
          ): const SizedBox.shrink(),
        )
      ],
    );
  }

  // Example placeholder widget methods
  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          TValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
          labelText: 'Attribute Name',
          hintText: 'Colors,Sizes,Material'
      ),
    );
  }

  Widget _buildAttributeTextField( ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller.attributes,
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            TValidator.validateEmptyText('Attribute Field', value),
        decoration: const InputDecoration(
            labelText: 'Attributes',
            hintText: 'Add attributes separated by | Example Green | Blue | Red',
            alignLabelWithHint: true
        ),
      ),
    );
  }

  Widget _buildAddAttributeButton( ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        icon: Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
            foregroundColor: TColors.black,
            backgroundColor: TColors.secondary,
            side: BorderSide(color: TColors.secondary)
        ),
        onPressed: () => controller.addNewAttribute(),
        label: const Text('Add'),
      ),
    );
  }

  Widget buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: TImages.defaultAttributeColorsImageIcon,
            ),
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text('There are no attributes added for this product'),
      ],
    );
  }

  ListView buildAttributesList(ProductAttributesController controller) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.productAttributes.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: TColors.white,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
          ),
          child: ListTile(
            title: const Text('Color'),
            subtitle: const Text('Green, Orange, Pink'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.trash, color: TColors.error),
            ),
          ),
        );
      },
    );
  }

}
