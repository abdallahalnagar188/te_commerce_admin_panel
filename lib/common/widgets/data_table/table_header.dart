import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/routes/routes.dart';
import 'package:te_commerce_admin_panel/utils/device/device_utility.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader({super.key, this.onPressed, required this.buttonText, this.textEditingController, this.searchOnChanged});

  final Function()? onPressed;
  final String buttonText;

  final TextEditingController? textEditingController;
  final Function(String)? searchOnChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: !TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed:  onPressed,
                      child: Text(buttonText)),
                ),
              ],
            )),
        Expanded(
            flex: !TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
            child: TextFormField(
              controller: textEditingController,
              onChanged: searchOnChanged,
              decoration: InputDecoration(
                  hintText: 'Search here...',
                  prefixIcon: Icon(Iconsax.search_normal)),
            ))
      ],
    );
  }
}
