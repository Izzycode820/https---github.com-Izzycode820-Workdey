import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/app.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/search_filter/search_context.dart';
import 'package:workdey_frontend/screens/findjob_home_screen.dart';
import 'package:workdey_frontend/screens/login_screen.dart';
import 'package:workdey_frontend/screens/messaging_screen.dart';
import 'package:workdey_frontend/screens/post_woker_screen.dart';
import 'package:workdey_frontend/screens/postjob_home_screen.dart';
import 'package:workdey_frontend/screens/profile_screen.dart';
import 'package:workdey_frontend/screens/saves_screen.dart';
import 'package:workdey_frontend/screens/settings_screen.dart';
import 'package:workdey_frontend/screens/signup_screen.dart';
import 'package:workdey_frontend/screens/workers_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
final searchContext = _getContextFromRoute(settings.name);

return MaterialPageRoute(
      builder: (context) {
        // Set the search context before building the widget
        ProviderScope.containerOf(context)
          .read(searchContextProvider.notifier)
          .state = searchContext;

return switch (settings.name) {
       AppRoutes.findJobs => const HomeScreen(),
       AppRoutes.postJobs => const PostedJobsScreen(),
       AppRoutes.postWorker => const PostedWorkersScreen(),
       AppRoutes.login => const LoginScreen(),
       AppRoutes.signup => const SignupScreen(),
       AppRoutes.home => const MainApp(),
       AppRoutes.messages => const MessagesScreen(),
       AppRoutes.workers => const WorkersScreen(),
       AppRoutes.savedJobs => const SavedJobsPage(),
       AppRoutes.profile => const ProfileScreen(),
       AppRoutes.settings => const SettingsScreen(),
          _ => const Scaffold(body: Center(child: Text('Route not found'))),
        };
      },
    );
  }

  static SearchContext _getContextFromRoute(String? routeName) {
    if (routeName?.contains('worker') ?? false) {
      return SearchContext.workers;
    }
    return SearchContext.jobs;
  }
}