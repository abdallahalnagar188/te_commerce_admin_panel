import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String? orderId;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.orderId,
    this.isRead = false,
    required this.createdAt,
  });

  // Convert model to JSON structure so that you can store it in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'orderId': orderId,
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }

  // Factory constructor to create a NotificationModel from a Firebase document snapshot
  factory NotificationModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return NotificationModel(
        id: document.id,
        title: data['title'] ?? '',
        body: data['body'] ?? '',
        orderId: data['orderId'],
        isRead: data['isRead'] ?? false,
        createdAt: data['createdAt'] != null 
            ? (data['createdAt'] as Timestamp).toDate() 
            : DateTime.now(),
      );
    } else {
      return NotificationModel.empty();
    }
  }

  // Static function to create an empty user model
  static NotificationModel empty() => NotificationModel(
        id: '',
        title: '',
        body: '',
        createdAt: DateTime.now(),
      );
}
