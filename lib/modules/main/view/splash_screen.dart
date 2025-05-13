import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb_app/modules/home/view/home_screen.dart';
import 'package:tmdb_app/resources/navigation_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      navigate(
        context: context,
        screen: HomeScreen(),
        type: NavigationType.pushAndRemoveUntil,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset("assets/lottie/splash.json", height: 200),
      ),
    );
  }
}
