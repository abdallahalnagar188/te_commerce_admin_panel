import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:te_commerce_admin_panel/data/repos/auth/auth_repo.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';
import 'package:te_commerce_admin_panel/features/auth/controllers/user_controller.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';
import 'package:te_commerce_admin_panel/utils/constants/enums.dart';
import 'package:te_commerce_admin_panel/utils/constants/text_strings.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

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

      // Form Validate
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email and Password Auth
      await AuthRepo.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Fetch user details and assign to user controller
      final user = await UserController.instance.fetchUserDetails();


      // Remove Loading
      TFullScreenLoader.stopLoading();

      // Redirect
      if(user.role != AppRole.admin){
        await AuthRepo.instance.logout();
        TLoaders.errorSnackBar(title: "Oh Snap", message: 'You are not auth or do not have access. contact admin for login in');
      }else{
        AuthRepo.instance.screenRedirect();

      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// Handel registration for admin user
  Future<void> registerAdmin() async {
   try {
     // Start Loading
     TFullScreenLoader.openLoadingDialog(
       'Reistering Admin Account...',
       TImages.docerAnimation,
     );

     // check Internet connection
     final isConnected = await NetworkManager.instance.isConnected();
     if (!isConnected) {
       TFullScreenLoader.stopLoading();
       return;
     }
     // Register user using Email and Password Auth
     await AuthRepo.instance
         .registerWithEmailAndPassword(TTexts.adminEmail, TTexts.adminPassword);

     // create admin record in the firebase
     final userRepo = Get.put(UserRepo());

     await userRepo.createUser(UserModel(
         email: TTexts.adminEmail,
         id: AuthRepo.instance.authUser!.uid,
         firstName: 'Abdallah',
         lastName: 'Alnagar Admin',
         role: AppRole.admin,
         createdAt: DateTime.now()));

     TFullScreenLoader.stopLoading();

     AuthRepo.instance.screenRedirect();
   } catch(e){
     TFullScreenLoader.stopLoading();
     TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
