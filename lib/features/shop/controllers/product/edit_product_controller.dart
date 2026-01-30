import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';

import '../../../../data/repos/shop/product/product_repo.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';
import '../../models/product_category_model.dart';
import '../../models/product_model.dart';
import '../category/category_controller.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final variationController = Get.put(ProductVariationsController());
  final attributesController = Get.put(ProductAttributesController());
  final imagesController = Get.put(ProductImageController());
  final productRepo = Get.put(ProductRepo());

  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // text editing controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController salePrice = TextEditingController();

  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel?> selectedCategories = <CategoryModel?>[].obs;
  final RxList<CategoryModel?> alreadyAddedCategories = <CategoryModel?>[].obs;

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDateUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  void initProductData(ProductModel product) {
    try {
      isLoading.value = true;

      title.text = product.title;
      description.text = product.description ?? "";
      productType.value = productType.value == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;

      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      if (product.images != null) {
        imagesController.selectedThumbnailImageUrl.value = product.thumbnail;
        imagesController.additionalProductImagesUrls
            .assignAll(product.images ?? []);
      }

      attributesController.productAttributes
          .assignAll(product.productAttributes ?? []);
      variationController.productVariations
          .assignAll(product.productVariations ?? []);
      variationController
          .initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;
    final productCategories = await productRepo.getProductCategories(productId);
    final categoryController = Get.put(CategoryController());

    if (categoryController.allItems.isEmpty) await categoryController.fetchItems();
    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final categories = categoryController.allItems
        .where((element) => categoriesIds.contains(element.id))
        .toList();

    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      showProgressDialog();
      // Start Loading
      TFullScreenLoader.popUpCircular();

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!titleDescriptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (selectedBrand.value == null) throw 'Select Brand for this product';

      if (productType.value == ProductType.variable &&
          ProductVariationsController.instance.productVariations.isEmpty) {
        throw 'There are non variations for the product type variable , create some variations or change Product type';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationsController
            .instance.productVariations
            .any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.isEmpty);

        if (variationCheckFailed) throw 'Variation data is not accurate. please check and try again';
      }

      thumbnailUploader.value = true;
      final imagesController = ProductImageController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null) throw 'Select Thumbnail Image';

      additionalImagesUploader.value = true;

      final variations = ProductVariationsController.instance.productVariations;
      if (productType.value == ProductType.variable && variations.isNotEmpty) {
        ProductVariationsController.instance.resetAllValues();
        variations.value = [];
      }

      // Map Data
      product.sku = '';
      product.isFeatured = true;
      product.title = title.text;
      product.brand = selectedBrand.value;
      product.description = description.text.trim();
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.images = imagesController.additionalProductImagesUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail = imagesController.selectedThumbnailImageUrl.value ?? '';
      product.productAttributes =
          ProductAttributesController.instance.productAttributes;
      product.productVariations = variations;

// Call Repository to Update New Product
      productDateUploader.value = true;
      await ProductRepo.instance.updateProduct(product);

// Register product categories if any
      if (selectedCategories.isNotEmpty) {
        // Loop through selected Product Categories
        categoriesRelationshipUploader.value = true;

        // Get the existing category IDs
        List<String> existingCategoryIds = alreadyAddedCategories
            .map((category) => category?.id ?? '')
            .toList();

        for (var category in selectedCategories) {
          // Check if the category is not already associated with the product
          if (!existingCategoryIds.contains(category?.id ?? '')) {
            // Map Data
            final productCategory = ProductCategoryModel(
              productId: product.id,
              categoryId: category?.id ?? '',
            );
            await ProductRepo.instance.createProductCategory(productCategory);
          }
        }
        for (var existingCategoryId in existingCategoryIds) {
          // Check if the category is not present in the selected categories
          if (!selectedCategories
              .any((category) => category?.id == existingCategoryId)) {
            // Remove the association
            await ProductRepo.instance
                .removeProductCategory(product.id, existingCategoryId);
          }
        }
      }

      ProductController.instance.updateItemFromLists(product);
      // Remove Loading
      TFullScreenLoader.stopLoading();
      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      debugPrint(e.toString());
    }
  }

  void showProgressDialog() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: Text('Creating Product'),
              content: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        TImages.creatingProductIllustration,
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      buildCheckBox('Thumbnail Image', thumbnailUploader),
                      buildCheckBox(
                          'Additional Images', additionalImagesUploader),
                      buildCheckBox('Product Date , Attributes and Variations',
                          productDateUploader),
                      buildCheckBox(
                          'Product Categories', categoriesRelationshipUploader),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const Text('Sit Tight, we are creating your product'),
                    ],
                  )),
            )));
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel image = selectedImages.first;
      ProductImageController.instance.selectedThumbnailImageUrl.value =
          image.url;
    }
  }

  // Build a chick box widget
  Widget buildCheckBox(String label, RxBool value) {
    return Row(children: [
      AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: Colors.blue,
                )
              : const Icon(CupertinoIcons.checkmark_alt_circle)),
      const SizedBox(
        width: TSizes.spaceBtwItems,
      ),
      Text(label)
    ]);
  }

  void showCompletionDialog() {
    Get.dialog(AlertDialog(
      title: Text('Congratulation'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text('Go to Products'),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            TImages.productsIllustration,
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            'Congratulation',
            style: Theme.of(Get.context!).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text('New Record has been added'),
        ],
      ),
    ));
  }

  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    description.clear();
    brandTextField.clear();
    price.clear();
    stock.clear();
    salePrice.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDateUploader.value = false;
    categoriesRelationshipUploader.value = false;
    ProductVariationsController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();
  }
}
