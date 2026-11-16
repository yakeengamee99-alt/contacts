import 'package:contact_assignment/core/routes/app_routes.dart';
import 'package:contact_assignment/home/home_screens.dart';
import 'package:contact_assignment/ui/splash/splash_screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.splash: (_) => SplashScreens(),
        AppRoutes.home: (Context) => HomeScreens(),
      },
      initialRoute: AppRoutes.splash,
    );
  }
}
