import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/login_provider.dart';
import 'package:workdey_frontend/core/routes/route_generator.dart';
import 'package:workdey_frontend/screens/findjob_home_screen.dart';
import 'package:workdey_frontend/screens/login_screen.dart';
import 'package:workdey_frontend/screens/messaging_screen.dart';
import 'package:workdey_frontend/screens/profile_screen.dart';
import 'package:workdey_frontend/screens/saves_screen.dart';
import 'package:workdey_frontend/screens/workers_screen.dart';
import 'package:workdey_frontend/shared/components/bottom_navbar.dart';

class WorkdeyApp extends StatelessWidget {
  const WorkdeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Workdey',
      debugShowCheckedModeBanner: false,
      theme: _buildWorkdeyTheme(),
      darkTheme: _buildDarkTheme(),
      onGenerateRoute: RouteGenerator.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text("Route not found!")),
        ),
      ),
    home: const App(), // This is the key change - use the App widget as home
    );
  }

  ThemeData _buildWorkdeyTheme() {
    const primaryGreen = Color(0xFF3E8728);
    const secondaryGreen = Color(0xFF07864B);
    const textDark = Color(0xFF181A1F);

    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryGreen,
        secondary: secondaryGreen,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black.withOpacity(0.9),
        selectedItemColor: const Color(0xFF3E8728),
        unselectedItemColor: Colors.grey.shade400,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Poppins'),
        bodyLarge: TextStyle(fontFamily: 'Inter'),
        bodyMedium: TextStyle(fontFamily: 'Inter'),
      ).apply(
        bodyColor: textDark,
        displayColor: textDark,
      ),
      //for card
    cardTheme: CardThemeData(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: secondaryGreen.withOpacity(0.2),
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.none,
    ),
    useMaterial3: true,
  );
  }

  ThemeData _buildDarkTheme() {
    return _buildWorkdeyTheme().copyWith(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF3E8728),
        secondary: Color(0xFF07864B),
        surface: Color(0xFF121212),
      ),
    );
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      initial: () => const LoginScreen(),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      authenticated: (response) {
        debugPrint("✅ User authenticated, building main app");
        return const MainApp();
      },
      error: (message) {
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        });
        return const LoginScreen();
      },
    );
  }
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {

  final List<Widget> _pages = [
    const EnhancedHomeScreen(),
    const MessagesScreen(),
    const WorkersScreen(),
    const SavedJobsPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}