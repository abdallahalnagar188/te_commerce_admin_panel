import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/address/address_repo.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

import '../../../auth/models/user_model.dart';
import '../../models/order_model.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressesLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();

  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  /// -- Load customer orders
  Future<void> getCustomerOrders() async {
    try {
      // Show loader while loading categories
      ordersLoading.value = true;

      // Fetch customer orders & addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders =
            await UserRepo.instance.getUserOrders(customer.value.id!);
      }

      // Update the orders list
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      // Filtered orders list
      filteredCustomerOrders.assignAll(customer.value.orders ?? []);

      // Add all rows as false [Not Selected], Toggle when required
      selectedRows.assignAll(List.generate(
          customer.value.orders != null ? customer.value.orders!.length : 0,
          (index) => false));
    } catch (e) {
      ordersLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  /// Load customer details
  Future<void> getCustomerAddress() async {
    try {
      addressesLoading.value = true;
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses =
            await addressRepository.fetchUserAddresses(customer.value.id!);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      addressesLoading.value = false;
    }
  }

  /// Search Query Filter
  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(allCustomerOrders.where((customer) =>
        customer.id.toLowerCase().contains(query.toLowerCase()) ||
        customer.orderDate
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())));
    update();
  }

  /// sorting related code
  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
      if (ascending) {
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      } else {
        return b.id.toLowerCase().compareTo(a.id.toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;
    update();
  }
}
