import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/bindings/general_bindings.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:te_commerce_admin_panel/routes/app_routes.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // static final Uri _productUri =
  //     Uri.parse('https://codingwitht.com/ecommerce-app-with-admin-panel/');
  //
  // Future<void> _openProductPage() async {
  //   // On web this will open a new tab automatically
  //   if (!await launchUrl(_productUri, webOnlyWindowName: '_blank')) {
  //     debugPrint('Could not launch $_productUri');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      getPages: TAppRoute.pages,
      initialBinding: GeneralBindings(),
      initialRoute: TRoutes.dashboard,
      unknownRoute: GetPage(name: '/page-not-found', page: () => Scaffold(body: Center(child: Text('Page Not Found'),),)),
    );
  }
}
