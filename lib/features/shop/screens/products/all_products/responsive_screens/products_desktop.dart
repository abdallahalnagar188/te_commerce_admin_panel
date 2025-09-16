import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:te_commerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../controllers/product/product_controller.dart';
import '../table/data_table.dart';

class ProductsDesktopScreen extends StatelessWidget {
  const ProductsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                  heading: 'Products', breadcrumbsItems: ['Products']),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) return const TLoaderAnimation();

                    return TRoundedContainer(
                      height: 500,
                      child: Column(
                        children: [
                          TTableHeader(
                            buttonText: 'Add Product',
                            onPressed: () => Get.toNamed(TRoutes.createProduct),searchOnChanged:(query) => controller.searchQuery(query),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                          Expanded(child: ProductsTable()),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
