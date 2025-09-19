import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:te_commerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/enums.dart';
import '../../models/order_model.dart';
import '../customer/customer_controller.dart';
import '../order/order_controller.dart';

class DashboardController extends TBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final customerController = Get.put(CustomerController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;



  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  // calculate weekly sales
  void _calculateWeeklySales() {
    // reset weekly sale to 0
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orderController.allItems) {
      final DateTime orderWeekStart =
          THelperFunctions.getStartOfWeek(order.orderDate);

      // check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure the index is non negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
      }
    }
  }

  void _calculateOrderStatusData() {
    orderStatusData.clear();

    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orderController.allItems) {
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  @override
  Future<void> deleteItem(OrderModel item) async {}

  @override
  Future<List<OrderModel>> fetchItems() async{
    if (orderController.allItems.isNotEmpty) {
      await orderController.fetchItems();
    }

    if(customerController.allItems.isNotEmpty){
      await customerController.fetchItems();
    }
    _calculateWeeklySales();
    _calculateOrderStatusData();
    return orderController.allItems;


  }
}
