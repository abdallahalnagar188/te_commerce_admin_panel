import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/product_model.dart';
import '../widgets/additional_images.dart' show ProductAdditionalImages;
import '../widgets/attributes_widget.dart' show ProductAttributes;
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart' show ProductBrand;
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart' show ProductTypeWidget;
import '../widgets/stock_pricing_widget.dart' show ProductStockAndPricing;
import '../widgets/thumbnail_widget.dart' show ProductThumbnailImage;
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart' show ProductVariations;
import '../widgets/visibility_widget.dart' show ProductVisibilityWidget;

class EditProductMobileScreen extends StatelessWidget {
  const EditProductMobileScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  ProductBottomNavigationButtons(product: product,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              const TBreadcrumbsWithHeading(
                heading: 'Update Product',
                breadcrumbsItems: [TRoutes.products, 'update product'],
                returnToPreviousScreen: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Create Product Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Information
                  const ProductTitleAndDescription(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Stock and Pricing
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Heading
                        Text(
                          'Stock and Pricing',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Product Type
                        const ProductTypeWidget(),
                        const SizedBox(height: TSizes.spaceBtwInputFields),

                        // Stock
                        const ProductStockAndPricing(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Attributes
                        const ProductAttributes(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Variations
                        const ProductVariations(),
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Thumbnail
                  const ProductThumbnailImage(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Images
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Product Images',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        ProductAdditionalImages(
                          additionalProductImagesURLs: RxList<String>.empty(),
                          onTapToAddImages: () {},
                          onTapToRemoveImage: (index) {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Brand
                  const ProductBrand(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Categories
                  ProductCategories(product: product),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Visibility
                  const ProductVisibilityWidget(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
