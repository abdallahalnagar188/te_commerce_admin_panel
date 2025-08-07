import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/headers/header.dart';

import '../../containers/rounded_container.dart';

class TabletLayout extends StatelessWidget {
   TabletLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(),
      appBar: THeader(scaffoldKey: scaffoldKey,),
      body: body ?? Container()
    );
  }
}
