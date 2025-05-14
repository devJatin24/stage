import 'package:flutter/material.dart';
import 'package:stage/main.dart';
import '../../../helper/app_utilities/app_images.dart';
import '../../../helper/routeAndBlocManager/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  startTimer() {
    Future.delayed(const Duration(seconds: 3), () => navigateInside());
  }

  navigateInside() async {
    Navigator.pushReplacementNamed(
      navigatorKey.currentContext!,
      AppRoutes.movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(child: Image.asset(AppImages.splash)),
      ),
    );
  }
}
