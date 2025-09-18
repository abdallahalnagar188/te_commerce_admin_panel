import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/additional_images.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/attributes_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/bottom_navigation_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/brand_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/categories_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/product_type_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/stock_pricing_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/thumbnail_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/title_description.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/variations_widget.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/visibility_widget.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';
import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_images_controller.dart';

class CreateProductDesktopScreen extends StatelessWidget {
  const CreateProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  Get.put(ProductImageController());
    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                heading: 'Create Product',
                breadcrumbsItems: [TRoutes.products, 'create product'],
                returnToPreviousScreen: true,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

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
                          const SizedBox(height: TSizes.spaceBtwSections),

                          // Stock and Pricing
                          TRoundedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading
                                Text('Stock and Pricing', style: Theme.of(context).textTheme.headlineSmall),
                                const SizedBox(height: TSizes.spaceBtwItems),

                                // Product Type
                                ProductTypeWidget(),
                                const SizedBox(height: TSizes.spaceBtwInputFields,),

                                // Stock
                                ProductStockAndPricing(),
                                const SizedBox(height: TSizes.spaceBtwSections,),

                                // Attributes
                                ProductAttributes(),
                                const SizedBox(height: TSizes.spaceBtwSections,),
                              ],
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections,),

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
                              additionalProductImagesURLs: controller.additionalProductImagesUrls,
                              onTapToAddImages: () => controller.selectMultipleProductImages(),
                              onTapToRemoveImage: (index)  => controller.removeImage(index),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: TSizes.spaceBtwSections,),

                      // Product Brand
                      const ProductBrand(),
                      SizedBox(height: TSizes.spaceBtwSections,),

                      // Product Categories
                      const ProductCategories(),
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
