import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';

class MobileLayout extends StatelessWidget {
   MobileLayout({super.key, this.body});


  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        drawer: Drawer(),
        appBar: THeader(scaffoldKey: scaffoldKey,),
        body: body ??  Container()
    );
  }
}
