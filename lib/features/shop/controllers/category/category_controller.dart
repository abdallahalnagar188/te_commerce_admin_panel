import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/category/category_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/colors.dart';
import 'package:te_commerce_admin_panel/utils/constants/sizes.dart';
import 'package:te_commerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

  // Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController();

  final categoryRep = Get.put(CategoryRepo());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await categoryRep.getAllCategories();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  void sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  void searchQuery(String query) {
    print(query);
    filteredItems.assignAll(allItems.where(
        (item) => item.name.toLowerCase().contains(query.toLowerCase())));
  }

  void confirmAndDeleteItem(CategoryModel category) {
    Get.defaultDialog(
        title: 'Delete Item',
        content: const Text('Are you sure you want to delete this item?'),
        confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
              onPressed: () async => await deleteOnConfirm(category),
              style: OutlinedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(TSizes.buttonRadius * 5))),
              child: Text('Ok')),
        ),
        cancel: SizedBox(
          width: 60,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
                backgroundColor: TColors.white,
                padding:
                    EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(TSizes.buttonRadius * 5))),
            child: Text(
              'Cancel',
              style: TextStyle(color: TColors.primary),
            ),
          ),
        ));
  }

  Future<void> deleteOnConfirm(CategoryModel category) async {
    try {
      TFullScreenLoader.stopLoading();

      TFullScreenLoader.popUpCircular();
      await categoryRep.deleteCategory(category.id);
      removeItemFromTheList(category);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your Item has been deleted');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void removeItemFromTheList(CategoryModel item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  void addItemToList(CategoryModel item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
    filteredItems.refresh();
  }

  void updateItemFromLists(CategoryModel category) {
    final itemIndex =  allItems.indexWhere((i) => i == category);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == category);

    if(itemIndex != -1) allItems[itemIndex] = category;
    if(filteredItemIndex != -1) filteredItems[itemIndex] = category;

    filteredItems.refresh();
  }
}
