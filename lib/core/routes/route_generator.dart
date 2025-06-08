// lib/core/routes/route_generator.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/screens/login_screen.dart';
import 'package:workdey_frontend/screens/signup_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      // ... other cases
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
        ));
    }
  }
}