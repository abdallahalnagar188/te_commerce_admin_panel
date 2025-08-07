import 'package:flutter/material.dart';
import 'package:te_commerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/headers/header.dart';
import 'package:te_commerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';

class DesktopLayout extends StatelessWidget {
   const DesktopLayout({super.key, this.body});

  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: TSidebar()),
          Expanded(
            flex: 5,
              child: Column(
            children: [
              /// Header
           THeader(),

              /// body
              body ?? const SizedBox()
            ],
          ))
        ],
      ),
    );
  }
}
