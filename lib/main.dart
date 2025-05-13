import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/modules/reviews/view_model/review_view_model.dart';
import 'package:tmdb_app/resources/app_colors.dart';

import 'modules/home/view/home_screen.dart';
import 'modules/home/view_model/home_view_model.dart';
import 'modules/main/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ReviewViewModel()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
              TargetPlatform.values,
              value: (_) => const FadeForwardsPageTransitionsBuilder(),
            ),
          ),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: AppColors.backgroundColor,
          ),
          useMaterial3: true,
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
