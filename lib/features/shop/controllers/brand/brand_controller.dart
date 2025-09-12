import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:te_commerce_admin_panel/data/repos/shop/brand/brand_repo.dart';
import 'package:te_commerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:te_commerce_admin_panel/features/shop/models/brand_model.dart';

class BrandController extends TBaseController<BrandModel>{
  static BrandController get instance => Get.find();

  final brandRepo = Get.put(BrandRepo());
  final categoryController = Get.put(CategoryController());

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());

  }

  @override
  Future<void> deleteItems(BrandModel item) async {
   BrandRepo.instance.deleteBrand(item);
  }

  @override
  Future<List<BrandModel>> fetchItems() async{
    final fetchedBrands = await brandRepo.getAllBrands();
    final fetchBrandCategories = await brandRepo.getAllBrandCategories();

    if(categoryController.allItems.isNotEmpty) await categoryController.fetchItems();

    for (var brand in fetchedBrands){
      List<String> categoryIds = fetchBrandCategories.where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();

      brand.brandCategories = categoryController.allItems.where((category) => categoryIds.contains(category.id)).toList();
    }
    return fetchedBrands;

  }

  void sortByName(int sortColumnIndex,bool ascending){
    sortByProperty(sortColumnIndex,ascending,(BrandModel brand) => brand.name.toLowerCase());
  }
}