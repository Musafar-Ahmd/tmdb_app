import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
 static roboto({color, double? fontSize, fontWeight}) {
    return GoogleFonts.roboto(color: color ?? Colors.white,
        fontSize: fontSize ?? 12.0,
        fontWeight: fontWeight ?? FontWeight.w500);
  }
}