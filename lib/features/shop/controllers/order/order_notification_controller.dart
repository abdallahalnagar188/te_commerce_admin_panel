import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/features/shop/models/order_model.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:audioplayers/audioplayers.dart';

class OrderNotificationController extends GetxController {
  static OrderNotificationController get instance => Get.find();

  StreamSubscription<QuerySnapshot>? _orderSubscription;
  bool _isInitialDataLoaded = false;
  
  final RxList<OrderModel> recentNotifications = RxList<OrderModel>();
  final RxInt unreadCount = 0.obs;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    _startListeningForNewOrders();
  }

  @override
  void onClose() {
    _orderSubscription?.cancel();
    _audioPlayer.dispose();
    super.onClose();
  }

  void _startListeningForNewOrders() {
    // Listen to the most recent order. When a new one is added, it will trigger an 'added' event.
    _orderSubscription = FirebaseFirestore.instance
        .collection('Orders')
        .orderBy('orderDate', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      
      if (!_isInitialDataLoaded) {
        _isInitialDataLoaded = true;
        return; // Skip the first load which contains the existing latest order
      }

      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final order = OrderModel.fromSnapshot(change.doc);
          recentNotifications.insert(0, order);
          unreadCount.value++;
          _playNotificationSound();
          _showOrderNotification(order);
        }
      }
    });
  }

  void _showOrderNotification(OrderModel order) {
    Get.snackbar(
      '🔔 New Order Received!',
      'Order #${order.id} for \$${order.totalAmount} has been placed.',
      backgroundColor: Colors.blueAccent.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 8),
      margin: const EdgeInsets.all(20),
      isDismissible: true,
      icon: const Icon(Iconsax.bag_tick, color: Colors.white),
      mainButton: TextButton(
        onPressed: () {
          Get.toNamed(TRoutes.orders);
        },
        child: const Text('View', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _playNotificationSound() async {
    try {
      // Play the local asset sound
      await _audioPlayer.play(AssetSource('sounds/second.mp3'));
      
      // Stop the sound after 1500 milliseconds
      await Future.delayed(const Duration(milliseconds: 1500));
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  void markAllAsRead() {
    unreadCount.value = 0;
  }
}
