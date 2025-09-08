import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/category/category_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

class CategoryController extends TBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();

final categoryRepo = Get.put(CategoryRepo());

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(CategoryModel item) async{
    await categoryRepo.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async{
    return categoryRepo.getAllCategories();
  }

  void sortByName(int sortColumnIndex,bool ascending){
    sortByProperty(sortColumnIndex,ascending,(CategoryModel category) => category.name.toLowerCase());
  }
}
