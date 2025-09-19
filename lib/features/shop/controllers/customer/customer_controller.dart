import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:te_commerce_admin_panel/data/repos/user/user_repo.dart';

import '../../../auth/models/user_model.dart';

class CustomerController extends TBaseController<UserModel>{
  static CustomerController get instance => Get.find();

  final customerRepo = Get.put(UserRepo());

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async{
   await customerRepo.deleteUser(item.id!);
  }

  void sortByName(int sortColumnIndex, bool sortAscending) {
    sortByProperty(sortColumnIndex, sortAscending, (UserModel a) => a.fullName.toString().toLowerCase());
  }

  @override
  Future<List<UserModel>> fetchItems()async {
  return  await customerRepo.getAllUsers();
  }
}