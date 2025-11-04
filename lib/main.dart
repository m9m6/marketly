import 'package:flutter/material.dart';
import 'package:marketly/screens/cart_screen.dart';
import 'package:marketly/screens/categories_screen.dart';
import 'package:marketly/screens/login_screen.dart';
import 'package:marketly/screens/profile_screen.dart';
import 'package:marketly/screens/sign_up_screen.dart';
import 'package:marketly/screens/splash_screen.dart';
import 'onboarding_Screens/onboarding_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
     Marketly());
}

class Marketly extends StatelessWidget {
  const Marketly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        CategoriesScreen.routeName: (context) => const CategoriesScreen(),
        CartScreen.routeName: (context) => const CartScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),


      },
    );
  }
}
