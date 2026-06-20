class SendNotificationService {
  static Future<void> sendOrderStatusUpdateNotification({
    required String token,
    required String orderId,
    required String newStatus,
  }) async {
    throw UnsupportedError('Push notifications are not supported on this platform.');
  }

  static void dispose() {}
}
