import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/order_model.dart';

class OrderDetailsController extends GetxController {
  static OrderDetailsController get instance => Get.find();

  RxBool isLoading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  /// Load Customer orders
  Future<void> getCustomerOfCurrentOrder() async {
    try {
      final user = await UserRepo.instance.fetchUserDetails(order.value.userId);
      customer.value = user;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
