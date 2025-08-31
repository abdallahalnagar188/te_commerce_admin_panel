import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final String? docId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String paymentMethod;
  final String? address;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.deliveryDate,
    this.paymentMethod = 'Paypal',
    this.address,
  });

  /// Computed property: formatted order date
  String get formattedOrderDate =>
      THelperFunctions.getFormattedDate(orderDate);

  /// Computed property: formatted delivery date
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  /// Computed property: status text for UI
  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  /// Static empty order (default values)
  static OrderModel empty() => OrderModel(
    id: '',
    userId: '',
    orderDate: DateTime.now(),
    status: OrderStatus.processing,
    totalAmount: 0,
  );

  /// Convert to JSON (for Firebase or APIs)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'docId': docId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'address': address,
    };
  }
}
