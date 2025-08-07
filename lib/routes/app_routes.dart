import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/app.dart';

// import other screens as needed...

import 'routes.dart';

class TAppRoute {
  static final List<GetPage> pages = [

     GetPage(name: TRoutes.responsiveDesignTutorialScreen, page: () =>  ResponsiveDesignScreen()),

    // GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    // GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    // GetPage(name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    // GetPage(name: TRoutes.dashboard, page: () => const DashboardScreen(), middlewares: [TRouteMiddleware()]),
    // GetPage(name: TRoutes.media, page: () => const MediaScreen(), middlewares: [TRouteMiddleware()]),
    //
    // // Banners
    // GetPage(name: TRoutes.banners, page: () => const BannersScreen(), middlewares: [TRouteMiddleware()]),
    // GetPage(name: TRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [TRouteMiddleware()]),
    // GetPage(name: TRoutes.editeBanner, page: () => const EditBannerScreen(), middlewares: [TRouteMiddleware()]),
    //
    // // Products
    // GetPage(name: TRoutes.products, page: () => const ProductsScreen(), middlewares: [TRouteMiddleware()]),
    // GetPage(name: TRoutes.createProduct, page: () => const CreateProductScreen(), middlewares: [TRouteMiddleware()]),
    // GetPage(name: TRoutes.editeProduct, page: () => const EditProductScreen(), middlewares: [TRouteMiddleware()]),
    //
    // // Categories
    // GetPage(name: TRoutes.categories, page: () => const CategoriesScreen(), middlewares: [TRouteMiddleware()]),
    // GetPage(name: TRoutes.createCategory, page: () => const CreateCategoryScreen(), middlewares: [TRouteMiddleware()]),
    // GetPage(name: TRoutes.editeCategory, page: () => const EditCategoryScreen(), middlewares: [TRouteMiddleware()]),

    // You can continue with brands, customers, etc.
  ];
}
