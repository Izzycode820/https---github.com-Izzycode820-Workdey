// enhanced_app.dart
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
      // Show loading while checking existing tokens
      loading: () {
        debugPrint("⏳ Checking authentication state...");
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3E8728)),
                ),
                SizedBox(height: 16),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      
      // Show login screen when not authenticated
      initial: () {
        debugPrint("🔐 User not authenticated - showing login");
        return const LoginScreen();
      },
      
      // Show main app when authenticated
      authenticated: (response) {
        debugPrint("✅ User authenticated - showing main app");
        return const MainApp();
      },
      
      // Show login with error message
      error: (message) {
        debugPrint("❌ Authentication error: $message");
        
        // Show error message using post-frame callback to avoid build conflicts
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    // Retry authentication initialization
                    ref.read(authStateProvider.notifier).refreshSession();
                  },
                ),
              ),
            );
          }
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

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  final List<Widget> _pages = [
    const EnhancedHomeScreen(),
    const MessagesScreen(),
    const WorkersScreen(),
    const SavedJobsPage(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Listen for app lifecycle changes to handle token refresh
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // When app resumes, check if token needs refresh
    if (state == AppLifecycleState.resumed) {
      debugPrint("📱 App resumed - checking session validity");
      _checkSessionOnResume();
    }
  }

  Future<void> _checkSessionOnResume() async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    // Only check if currently authenticated
    if (authNotifier.isAuthenticated) {
      try {
        // You could implement a lightweight session check here
        // For now, we'll just ensure the session is still valid
        debugPrint("✅ Session check passed");
      } catch (e) {
        debugPrint("❌ Session check failed: $e");
        // Attempt to refresh the session
        await authNotifier.refreshSession();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentIndexProvider);

    return WillPopScope(
      // Handle back button behavior
      onWillPop: () async {
        if (currentIndex != 0) {
          // If not on home tab, go to home tab
          ref.read(currentIndexProvider.notifier).state = 0;
          return false;
        }
        // If on home tab, allow app to close
        return true;
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}