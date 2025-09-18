import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controllers/product/edit_product_controller.dart';
import '../../../../models/product_model.dart';
import '../widgets/additional_images.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/thumbnail_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';


class EditProductDesktopScreen extends StatelessWidget {
  const EditProductDesktopScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productImageController = Get.put(ProductImageController());
    productImageController.additionalProductImagesUrls.assignAll(product.images ?? []);

    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(product: product,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                heading: 'Update Product',
                breadcrumbsItems: [TRoutes.products, 'update product'],
                returnToPreviousScreen: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: !TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic Information
                          const ProductTitleAndDescription(),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          // Stock and Pricing
                          TRoundedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading
                                Text(
                                  'Stock and Pricing',
                                  style:
                                  Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),

                                // Product Type
                                ProductTypeWidget(),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),

                                // Stock
                                ProductStockAndPricing(),
                                const SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),

                                // Attributes
                                ProductAttributes(),
                                const SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          // Variation
                          ProductVariations(),
                        ],
                      )),
                  SizedBox(width: TSizes.spaceBtwSections,),

                  // Slider
                  Expanded(
                      child: Column(
                        children: [
                          // Product Thumbnail
                          const ProductThumbnailImage(),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          // Product Images
                          TRoundedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'All Product Images',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),
                                ProductAdditionalImages(
                                  additionalProductImagesURLs: productImageController.additionalProductImagesUrls,
                                  onTapToAddImages: () => productImageController.selectMultipleProductImages(),
                                  onTapToRemoveImage: (index) => productImageController.removeImage(index),
                                )

                              ],
                            ),
                          ),

                          SizedBox(height: TSizes.spaceBtwSections,),

                          // Product Brand
                          const ProductBrand(),
                          SizedBox(height: TSizes.spaceBtwSections,),

                          // Product Categories
                           ProductCategories(product:product ,),
                          SizedBox(height: TSizes.spaceBtwSections,),

                          // Product Visibility
                          const ProductVisibilityWidget(),
                          SizedBox(height: TSizes.spaceBtwSections,),


                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
