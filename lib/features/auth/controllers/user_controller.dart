import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepo = Get.put(UserRepo());

  /// Fetch user details from the repo
  Future<UserModel> fetchUserDetails() async {
    try{
      final user = await userRepo.fetchAdminDetails();
      return user;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Something went wrong...', message: e.toString());
      return UserModel.empty();
    }
  }
}
