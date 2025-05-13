import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

AppBar commonAppBar({
  required Widget title,
  bool? centerTile,
  required BuildContext context,
  double? toolbarHeight
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios,color: Colors.white,),
    ),
    toolbarHeight: toolbarHeight,
    surfaceTintColor: Colors.transparent,
    backgroundColor: AppColors.backgroundColor,
    centerTitle: centerTile,
    title: title,
  );
}
