import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/orders/orders_repo.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/order_model.dart';

class OrderController extends TBaseController<OrderModel> {
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.put(OrderRepo());

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    return await _orderRepository.getAllOrders();
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
            (OrderModel o) => o.totalAmount.toString().toLowerCase());
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
            (OrderModel o) => o.orderDate.toString().toLowerCase());
  }

  /// Update Order Status
  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(order.docId, {'status': newStatus.toString()},);
      updateItemFromLists(order);
      orderStatus.value = newStatus;
      TLoaders.successSnackBar(title: 'Updated', message: 'Order Status Updated');
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}
