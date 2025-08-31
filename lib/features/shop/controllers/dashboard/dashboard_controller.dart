import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/enums.dart';
import '../../models/order_model/order_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  ///  Orders
  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      totalAmount: 265,
      orderDate: DateTime(2024, 5, 20),
      deliveryDate: DateTime(2024, 5, 20),
    ),
    OrderModel(
      id: 'CWT0025',
      status: OrderStatus.shipped,
      totalAmount: 369,
      orderDate: DateTime(2024, 5, 21),
      deliveryDate: DateTime(2024, 5, 21),
    ),
    OrderModel(
      id: 'CWT0152',
      status: OrderStatus.delivered,
      totalAmount: 254,
      orderDate: DateTime(2024, 5, 22),
      deliveryDate: DateTime(2024, 5, 22),
    ),
    OrderModel(
      id: 'CWT0265',
      status: OrderStatus.delivered,
      totalAmount: 355,
      orderDate: DateTime(2024, 5, 23),
      deliveryDate: DateTime(2024, 5, 23),
    ),
    OrderModel(
      id: 'CWT1536',
      status: OrderStatus.delivered,
      totalAmount: 115,
      orderDate: DateTime(2024, 5, 24),
      deliveryDate: DateTime(2024, 5, 24),
    ),
  ];

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
    for (var order in orders) {
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

    for (var order in orders) {
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
}
