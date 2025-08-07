import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/headers/header.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';

import '../../containers/rounded_container.dart';

class TabletLayout extends StatelessWidget {
   TabletLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: TSidebar(),
      appBar: THeader(scaffoldKey: scaffoldKey,),
      body: body ?? Container()
    );
  }
}
