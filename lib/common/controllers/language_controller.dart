import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  static LanguageController get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Initialize with saved language or device locale
    final savedLang = deviceStorage.read('user_language');
    if (savedLang != null) {
      Get.updateLocale(Locale(savedLang));
    }
  }

  /// Toggle User Language
  void changeLanguage() {
    final currentLocale = Get.locale?.languageCode;
    Locale newLocale;
    if (currentLocale == 'ar') {
      newLocale = const Locale('en', 'US');
    } else {
      newLocale = const Locale('ar', 'EG');
    }

    Get.updateLocale(newLocale);
    deviceStorage.write('user_language', newLocale.languageCode);
  }
}
