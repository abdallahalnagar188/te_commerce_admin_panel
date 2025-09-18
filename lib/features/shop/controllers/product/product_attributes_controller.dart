import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/models/product_attribut_model.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/dialogs.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/models/image/image_model.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  final loading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final List<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;

// fun to add new attribute
  void addNewAttribute() {
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }

    // add attribute to list of attributes
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList()));

    // clear text filed after adding
    attributeName.text ='';
    attributes.text ='';

  }

  void removeAttribute(int index , BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      onConfirm: () {
        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        ProductVariationsController.instance.productVariations.value =[];
      }
    );
  }
  // fun to reset product Attributes
  void resetProductAttributes() {
    productAttributes.clear();
  }

}
