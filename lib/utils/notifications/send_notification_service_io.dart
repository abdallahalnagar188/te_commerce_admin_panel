import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

class SendNotificationService {
  static final Client _client = Client();

  static Future<String> _getFcmAccessToken() async {
    try {
      final jsonString = await rootBundle.loadString('assets/service.json');
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      final credentials = ServiceAccountCredentials.fromJson(jsonData);
      const scopes = ['https://www.googleapis.com/auth/cloud-platform'];

      final authClient = await clientViaServiceAccount(
        credentials, 
        scopes, 
        baseClient: _client,
      );
      
      final accessToken = authClient.credentials.accessToken.data;
      authClient.close();

      return accessToken;
    } catch (e) {
      debugPrint('Error getting FCM access token: $e');
      throw Exception('Failed to get FCM access token. Make sure assets/service.json exists.');
    }
  }

  static Future<void> sendOrderStatusUpdateNotification({
    required String token,
    required String orderId,
    required String newStatus,
  }) async {
    await _sendNotification(
      token: token,
      title: 'Order Update'.tr,
      body: 'Your order #$orderId status has been updated to $newStatus.'.tr,
    );
  }

  static Future<void> _sendNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      final accessToken = await _getFcmAccessToken();
      // Replace with your actual project ID
      final url = Uri.parse(
          'https://fcm.googleapis.com/v1/projects/noah-door-2/messages:send');

      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "message": {
            "token": token,
            "notification": {
              "body": body,
              "title": title,
            },
            // Android specific configurations
            "android": {"priority": "HIGH"},
            // iOS specific configurations
            "apns": {
              "headers": {"apns-priority": "10"}
            }
          }
        }),
      );

      if (response.statusCode != 200) {
        debugPrint('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }

  static void dispose() {
    _client.close();
  }
}
