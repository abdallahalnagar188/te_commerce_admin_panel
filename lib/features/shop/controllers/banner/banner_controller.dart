import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';

import '../../../../data/repos/shop/banners/banners_repo.dart';
import '../../models/banner_model.dart';

class BannerController extends TBaseController<BannerModel>{
  static BannerController get instance => Get.find();

  final bannerRepo = Get.put(BannersRepo());

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;

  }

  @override
  Future<void> deleteItem(BannerModel item) async {
   bannerRepo.deleteBanner(item.id?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async{
    return await bannerRepo.getAllBanners();
  }

  /// Method for formating a route string
  String formatRoute(String route) {
    if(route.isEmpty) return '';
    String formated = route.substring(1);

    formated = formated[0].toUpperCase() + formated.substring(1);
    return formated;
  }

}