import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/product/product_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/product_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/product_varation_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/image_strings.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';
import '../../models/product_category_model.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepo = Get.put(ProductRepo());
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

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDateUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  Future<void> createProduct() async {
    try {
      showProgressDialog();
      // // Start Loading
      // TFullScreenLoader.popUpCircular();

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
      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        description: description.text.trim(),
        brand: selectedBrand.value!,
        productVariations: variations,
        productType: productType.value.toString(),
        productAttributes: ProductAttributesController.instance.productAttributes,
        price: double.tryParse(price.text.trim()) ?? 0.0,
        stock: int.tryParse(stock.text.trim()) ?? 0,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0.0,
        thumbnail: imagesController.selectedThumbnailImageUrl.value!,
        images: imagesController.additionalProductImagesUrls,
        date: DateTime.now(),
        categoryId: selectedCategories.first?.id,  // ✅ assign category
      );


      // call repo to create new product
      productDateUploader.value = true;
      newRecord.id = await productRepo.createProduct(newRecord);

      // register product categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Failed to create new product';

        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          // Map data
          final productCategory = ProductCategoryModel(
              productId: newRecord.id, categoryId: category!.id);
          // call repo to create new product category
          await productRepo.createProductCategory(productCategory);
        }
      }
      ProductController.instance.addItemToList(newRecord);

      // Remove Loading
      TFullScreenLoader.stopLoading();
      showCompletionDialog();
      TLoaders.successSnackBar(
          title: 'Congratulation', message: 'New Record has been added');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
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

  void showProgressDialog() {
    showDialog(context: Get.context!,
        barrierDismissible: false,
        builder: (context) =>
            PopScope(
                canPop: false,
                child: AlertDialog(
                  title: Text('Creating Product'),
                  content: Obx(
                          () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(TImages.creatingProductIllustration,height: 200,width: 200,),
                          const SizedBox(height: TSizes.spaceBtwItems,),
                          buildCheckBox('Thumbnail Image', thumbnailUploader),
                          buildCheckBox('Additional Images', additionalImagesUploader),
                          buildCheckBox('Product Date , Attributes and Variations', productDateUploader),
                          buildCheckBox('Product Categories', categoriesRelationshipUploader),
                          const SizedBox(height: TSizes.spaceBtwItems,),
                          const Text('Sit Tight, we are creating your product'),
                        ],
                      )
                  ),
                ))
    );
  }

  // Build a chick box widget
  Widget buildCheckBox(String label, RxBool value) {
    return Row(children: [
      AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue,)
              : const Icon(CupertinoIcons.checkmark_alt_circle)
      ),
      const SizedBox(width: TSizes.spaceBtwItems,),
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
