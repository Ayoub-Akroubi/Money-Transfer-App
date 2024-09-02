import 'package:flutter/material.dart';
import 'package:money_transfer_app/src/screens/home_screen.dart';
import 'package:money_transfer_app/src/screens/login_screen.dart';
import 'package:money_transfer_app/src/screens/register_screen.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/homeScreen': (context) => const HomeScreen(),
  };
}