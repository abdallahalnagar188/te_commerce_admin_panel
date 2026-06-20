import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/orders/orders_repo.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/order_model.dart';
import '../../../personalization/models/notification_model.dart';
import '../../../../utils/notifications/send_notification_service.dart';

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
      
      // 1. Fetch User's Document to get FCM Token
      final userDoc = await FirebaseFirestore.instance.collection('Users').doc(order.userId).get();
      
      if (userDoc.exists) {
        final userData = userDoc.data();
        
        // 1.5 Update the order status in the user's personal Orders subcollection
        try {
          final userOrdersSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(order.userId)
              .collection('Orders')
              .where('id', isEqualTo: order.id)
              .get();
              
          for (var doc in userOrdersSnapshot.docs) {
            await doc.reference.update({'status': newStatus.toString()});
          }
        } catch (e) {
          print("Failed to update user's personal order document: $e");
        }
        
        // 2. Create Notification Document
        final notificationRef = FirebaseFirestore.instance
            .collection('Users')
            .doc(order.userId)
            .collection('Notifications')
            .doc();
            
        final notification = NotificationModel(
          id: notificationRef.id,
          title: 'Order Update'.tr,
          body: 'Your order #${order.id} status has been updated to ${newStatus.name}.'.tr,
          orderId: order.id,
          createdAt: DateTime.now(),
        );
        
        await notificationRef.set(notification.toJson());
        
        // 3. Trigger Push Notification (FCM)
        final fcmToken = userData?['fcmToken'];
        if (fcmToken != null && fcmToken.toString().isNotEmpty) {
           await SendNotificationService.sendOrderStatusUpdateNotification(
              token: fcmToken.toString(),
              orderId: order.id,
              newStatus: newStatus.name,
           );
        } else {
           print("No FCM token found for user ${order.userId}. Push notification skipped.");
        }
      } else {
         print("User ${order.userId} not found in Firestore.");
      }

      TLoaders.successSnackBar(title: 'Updated', message: 'Order Status Updated \n & Notification Sent');
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}
