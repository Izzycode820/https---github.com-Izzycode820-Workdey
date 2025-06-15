import 'package:flutter/material.dart';
import 'package:workdey_frontend/app.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/screens/findjob_home_screen.dart';
import 'package:workdey_frontend/screens/login_screen.dart';
import 'package:workdey_frontend/screens/messaging_screen.dart';
import 'package:workdey_frontend/screens/postjob_home_screen.dart';
import 'package:workdey_frontend/screens/profile_screen.dart';
import 'package:workdey_frontend/screens/saves_screen.dart';
import 'package:workdey_frontend/screens/signup_screen.dart';
import 'package:workdey_frontend/screens/workers_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.findJobs:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.postJobs:
        return MaterialPageRoute(builder: (_) => const PostedJobsScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainApp());
      case AppRoutes.messages:
        return MaterialPageRoute(builder: (_) => const MessagesScreen());
      case AppRoutes.workers:
        return MaterialPageRoute(builder: (_) => const WorkersScreen());
      case AppRoutes.savedJobs:
        return MaterialPageRoute(builder: (_) => const SavedJobsPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
        ));
    }
  }
}