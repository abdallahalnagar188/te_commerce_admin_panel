import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';

import '../../layouts/headers/header.dart';

class MobileLayout extends StatelessWidget {
   MobileLayout({super.key, this.body});


  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        drawer: TSidebar(),
        appBar: THeader(scaffoldKey: scaffoldKey,),
        body: body ??  Container()
    );
  }
}
