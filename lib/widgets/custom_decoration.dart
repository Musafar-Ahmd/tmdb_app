import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

customDecoration() {
  return InputDecoration(
    hintStyle: AppFonts.roboto(fontSize: 14, color: AppColors.backgroundColor),
    hintText: "Search for items",
    filled: true,
    fillColor: Colors.grey[200],
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
