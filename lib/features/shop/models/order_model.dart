import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id; // custom order id
  final String docId; // Firestore document id
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.docId = '',
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    this.shippingCost = 0.0,
    this.taxCost = 0.0,
    required this.orderDate,
    this.paymentMethod = 'Cash on Delivery',
    this.shippingAddress,
    this.billingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  // Format order date for UI
  String get formattedOrderDate =>
      THelperFunctions.getFormattedDate(orderDate);

  // Format delivery date for UI
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  // Status text for UI
  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  // empty Order Model
  static OrderModel empty() {
    return OrderModel(
      id: '',
      userId: '',
      status: OrderStatus.processing,
      items: [],
      totalAmount: 0.0,
      orderDate: DateTime.now(),
    );
  }

  // Convert model to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'docId': docId,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Create model from Firestore snapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] ?? '',
      docId: snapshot.id,
      userId: data['userId'] ?? '',
      status: OrderStatus.values.firstWhere(
            (e) => e.toString() == data['status'],
        orElse: () => OrderStatus.processing,
      ),
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      shippingCost: (data['shippingCost'] ?? 0).toDouble(),
      taxCost: (data['taxCost'] ?? 0).toDouble(),
      orderDate: DateTime.tryParse(data['orderDate'] ?? '') ?? DateTime.now(),
      paymentMethod: data['paymentMethod'] ?? 'Cash on Delivery',
      deliveryDate: data['deliveryDate'] != null
          ? DateTime.tryParse(data['deliveryDate'])
          : null,
      shippingAddress: data['shippingAddress'] != null
          ? AddressModel.fromMap(data['shippingAddress'])
          : null,
      billingAddress: data['billingAddress'] != null
          ? AddressModel.fromMap(data['billingAddress'])
          : null,
      billingAddressSameAsShipping:
      data['billingAddressSameAsShipping'] ?? true,
      items: (data['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
}
