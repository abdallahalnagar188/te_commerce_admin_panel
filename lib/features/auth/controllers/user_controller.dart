import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';
import 'package:te_commerce_admin_panel/features/auth/models/user_model.dart';
import 'package:te_commerce_admin_panel/utils/popups/loaders.dart';

import '../../media/controller/media_controller.dart';
import '../../media/models/image/image_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepo = Get.put(UserRepo());

  RxBool isLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

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

  /// Update user details
  Future<void> updateUser() async {
    try{

      if(formKey.currentState!.validate()){
        isLoading.value = true;
        user.value.firstName = firstNameController.text;
        user.value.lastName = lastNameController.text;
        user.value.phoneNumber = phoneController.text;

        await userRepo.updateUserDetails(user.value);

        TLoaders.successSnackBar(title: 'Success', message: 'User Updated Successfully');
        isLoading.value = false;
      }
    }catch(e){

      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong...', message: e.toString());
    }
  }
  ///   // Pick image from media
void updateProfilePicture()async{
    try{
      isLoading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

      if(selectedImages != null && selectedImages.isNotEmpty){
        ImageModel selectedImage = selectedImages.first;
        await userRepo.updateSingleField({'ProfilePicture': selectedImage.url});
        user.value.profilePicture = selectedImage.url;
        user.refresh();

        TLoaders.successSnackBar(title: "Success", message: "Profile Picture Updated Successfully");
      }

      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
}
}
