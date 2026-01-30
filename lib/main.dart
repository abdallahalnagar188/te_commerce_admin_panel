import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:te_commerce_admin_panel/data/repos/auth/auth_repo.dart';
import 'package:te_commerce_admin_panel/firebase_options.dart';
import 'package:te_commerce_admin_panel/utils/constants/supabase_config.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage
  await GetStorage.init();

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize Supabase
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthRepo()));


  runApp(const App());
}
