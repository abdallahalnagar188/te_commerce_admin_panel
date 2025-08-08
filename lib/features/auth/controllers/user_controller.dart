import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepo = Get.put(UserRepo());

  RxBool isLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }
  /// Fetch user details from the repo
  Future<UserModel> fetchUserDetails() async {
    try{
      isLoading.value = true;
      final user = await userRepo.fetchAdminDetails();
      this.user.value = user;
      isLoading.value = false;
      return user;
    }catch(e){
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong...', message: e.toString());
      return UserModel.empty();
    }
  }
}
