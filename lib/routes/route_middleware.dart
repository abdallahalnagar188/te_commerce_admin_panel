import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:te_commerce_admin_panel/data/repos/auth/auth_repo.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';

class TRouteMiddleware extends GetMiddleware{


  @override
  RouteSettings? redirect(String? route) {

    print('........................Middleware called......................');
    return AuthRepo.instance.isAuthenticated? null : const RouteSettings(name: TRoutes.login);

  }
}