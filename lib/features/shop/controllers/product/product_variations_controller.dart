import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/product_varation_model.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/products/create_product/widgets/variations_widget.dart';
import 'package:te_commerce_admin_panel/utils/popups/dialogs.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';

class ProductVariationsController extends GetxController{
  static ProductVariationsController get instance => Get.find();

// Observables for loading state and product variations
  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;

// Lists to store controllers for each variation attribute
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>> descriptionControllersList = [];

// Instance of ProductAttributesController
  final attributesController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Clear existing lists
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock Controllers
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] =
          TextEditingController(text: variation.stock.toString());
      stockControllersList.add(stockControllers);

      // Price Controllers
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] =
          TextEditingController(text: variation.price.toString());
      priceControllersList.add(priceControllers);

      // Sale Price Controllers
      Map<ProductVariationModel, TextEditingController> salePriceControllers = {};
      salePriceControllers[variation] =
          TextEditingController(text: variation.salePrice.toString());
      salePriceControllersList.add(salePriceControllers);

      // Description Controllers
      Map<ProductVariationModel, TextEditingController> descriptionControllers = {};
      descriptionControllers[variation] =
          TextEditingController(text: variation.description);
      descriptionControllersList.add(descriptionControllers);
    }
  }

  void removeVariations(BuildContext context){
    TDialogs.defaultDialog(context: context,title: 'Remove Variations',onConfirm: (){
      productVariations.value = [];
      resetAllValues();
      Navigator.of(context).pop();
    });
  }


  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(context: context,
    confirmText:'Generate',
      title: 'Generate Variations',
      content: 'Once the variation are created, you cannot add more attributes . In order to add more variations , you have to delete any of the attributes.',
      onConfirm: () => generateVariationsFromAttributes(context),

    );
  }

  void generateVariationsFromAttributes(BuildContext context) {

    Get.back();

    final  List<ProductVariationModel> variations = [];

    if(attributesController.productAttributes.isNotEmpty){
      final List<List<String>> attributeCombinations = getCombinations(attributesController.productAttributes.map((e) => e.values ?? <String>[]).toList());

      for(final combination in attributeCombinations){
        final Map<String, String> attributeValues  = Map.fromIterables(attributesController.productAttributes.map((e) => e.name ??''), combination);

        final ProductVariationModel variation = ProductVariationModel(id:   UniqueKey().toString(),attributeValues: attributeValues);
        variations.add(variation);

        // Create controllers
        final Map<ProductVariationModel, TextEditingController> stockController = {};
        final Map<ProductVariationModel, TextEditingController> priceController = {};
        final Map<ProductVariationModel, TextEditingController> salePriceController = {};
        final Map<ProductVariationModel, TextEditingController> descriptionController = {};


        // Assuming Variations is your current ProductVariationModel
        stockController[variation] = TextEditingController(text: variation.stock.toString());
        priceController[variation] = TextEditingController(text: variation.price.toString());
        salePriceController[variation] = TextEditingController(text: variation.salePrice.toString());
        descriptionController[variation] = TextEditingController(text: variation.description);

        // Add the maps to their respective lists
        stockControllersList.add(stockController);
        priceControllersList.add(priceController);
        salePriceControllersList.add(salePriceController);
        descriptionControllersList.add(descriptionController);
      }
    }
    productVariations.assignAll(variations);

  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    final List<List<String>> result = [];

    combine(lists,0,<String>[],result);

    return result;
  }

  void combine(List<List<String>> lists, int index, List<String> current, List<List<String>> result) {
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }
    for (final item in lists[index]) {
      final List<String> updated = List.from(current)..add(item);
      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

  }

}