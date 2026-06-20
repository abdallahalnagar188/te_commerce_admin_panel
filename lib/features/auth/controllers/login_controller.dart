import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:te_commerce_admin_panel/data/repos/auth/auth_repo.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/setting/settings_repo.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';
import 'package:te_commerce_admin_panel/features/auth/controllers/user_controller.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';

import 'package:te_commerce_admin_panel/utils/roles.dart';
import 'package:te_commerce_admin_panel/utils/constants/text_strings.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../personalization/models/settings_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Handel email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        TImages.docerAnimation,
      );

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }



      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      print('--- LOGIN REQUEST ---');
      print('Email: ${email.text.trim()}');

      // Login user using Email and Password Auth
      final userCreds = await AuthRepo.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      print('--- LOGIN RESPONSE ---');
      print('Success: UID ${userCreds.user?.uid}');

      // Fetch user details and assign to user controller
      print('Fetching User Details...');
      final user = await UserController.instance.fetchUserDetails();
      print('User Fetched: ${user.toJson()}');

      // Remove Loading
      TFullScreenLoader.stopLoading();

      // Redirect
      if (user.role != AppRole.admin) {
        await AuthRepo.instance.logout();
        TLoaders.errorSnackBar(
            title: "No Auth",
            message:
                'You are not auth or do not have access. contact admin for login in');
      } else {
        AuthRepo.instance.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      print('ERROR during login: ${e.toString()}');
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// Handel registration for admin user
  Future<void> registerAdmin() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Registering Admin Account...',
        TImages.docerAnimation,
      );

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      final emailText = email.text.trim();
      final passwordText = password.text.trim();

      print('--- REGISTER REQUEST ---');
      print('Email: $emailText');

      // Register user using Email and Password Auth
      final userCreds = await AuthRepo.instance.registerWithEmailAndPassword(
          emailText, passwordText);

      print('--- REGISTER RESPONSE ---');
      print('Success: UID ${userCreds.user?.uid}');

      // create admin record in the firebase
      final userRepo = Get.put(UserRepo());

      print('--- CREATE FIRESTORE USER REQUEST ---');
      await userRepo.createUser(UserModel(
          email: emailText,
          id: AuthRepo.instance.authUser!.uid,
          firstName: 'Admin',
          lastName: 'User',
          role: AppRole.admin,
          createdAt: DateTime.now()));
          
      print('--- CREATE FIRESTORE USER RESPONSE ---');
      print('Success!');

      final settingsRepo = Get.put(SettingsRepository());
      await settingsRepo.registerSettings(
        SettingModel(
          appName: '',
          appLogo: '',
          freeShippingThreshold: 0.0,
          shippingCost: 0.0,
          taxRate: 0.0,
        ),
      );

      TFullScreenLoader.stopLoading();

      AuthRepo.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      print('ERROR during registration: ${e.toString()}');
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      await AuthRepo.instance.logout();
      AuthRepo.instance.screenRedirect();
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
