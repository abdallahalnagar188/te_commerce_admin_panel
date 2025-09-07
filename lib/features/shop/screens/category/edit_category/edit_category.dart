import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/features/shop/models/category_model.dart';
import 'package:te_commerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments ;
    return TSiteTemplate(
      desktop: EditCategoryDesktopScreen(category: category,),
    );
  }
}
