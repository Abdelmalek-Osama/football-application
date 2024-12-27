import 'package:flutter/material.dart';

import '../constants.dart';
import 'customtext.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomAppBar({super.key, required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarBackgroundColor,
      title: CustomText(
        text: title,
        isBold: true,
        fontSize: 30,
        colours: primaryTextColor,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}