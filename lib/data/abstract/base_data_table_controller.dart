import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../../utils/popups/loaders.dart';

abstract class TBaseController<T> extends GetxController {
  RxBool isLoading = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

  // Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController();



  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<List<T>> fetchItems() ;

  Future<void> deleteItem(T item) ;

  bool containsSearchQuery(T item,String query);

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value =false;
    }
  }



  void searchQuery(String query) {
    filteredItems.assignAll(allItems.where((item) => containsSearchQuery(item,query),));
  }

  void sortByProperty(int columnIndex, bool ascending,Function(T) property) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  void addItemToList(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  void updateItemFromLists(T item) {
    final itemIndex =  allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if(itemIndex != -1) allItems[itemIndex] = item;
    if(filteredItemIndex != -1) filteredItems[itemIndex] = item;

    filteredItems.refresh();
  }

  void confirmAndDeleteItem(T item) {
    Get.defaultDialog(
        title: 'Delete Item',
        content: const Text('Are you sure you want to delete this item?'),
        confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
              onPressed: () async => await deleteOnConfirm(item),
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

  Future<void> deleteOnConfirm(T item) async {
    try {
      TFullScreenLoader.stopLoading();

      TFullScreenLoader.popUpCircular();
      await deleteItem(item);
      removeItemFromTheList(item);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your Item has been deleted');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void removeItemFromTheList(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }
}
