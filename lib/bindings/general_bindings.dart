import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/utils/helpers/network_manager.dart';

import '../features/auth/controllers/user_controller.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    /// core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }

}