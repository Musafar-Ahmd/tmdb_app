import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb_app/resources/app_fonts.dart';

notFound(String title) {
  return SizedBox(
    height: 500,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LottieBuilder.asset(
            "assets/lottie/not_item.json",
            height: 200,
          ),
        ),
        Text(
          title,
          style: AppFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
