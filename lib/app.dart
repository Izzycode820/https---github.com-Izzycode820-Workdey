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
      home: const App(),
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
      // Enhanced text theme with better sizing
      textTheme: _buildResponsiveTextTheme(),
      cardTheme: CardThemeData(
        elevation: 2, // Reduced from 4 for more natural feel
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: secondaryGreen.withOpacity(0.1),
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.none,
      ),
      // Add input decoration theme for forms
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      // Add elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      useMaterial3: true,
    );
  }

  // LinkedIn-style responsive text theme
  TextTheme _buildResponsiveTextTheme() {
    return const TextTheme(
      // Headlines
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      
      // Headlines
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      
      // Titles
      titleLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      
      // Body text
      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      
      // Labels
      labelLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    ).apply(
      bodyColor: const Color(0xFF181A1F),
      displayColor: const Color(0xFF181A1F),
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
      loading: () => const _LoadingScreen(),
      initial: () {
        debugPrint("🔐 User not authenticated - showing login");
        return const LoginScreen();
      },
      authenticated: (response) {
        debugPrint("✅ User authenticated - showing main app");
        return const MainApp();
      },
      error: (message) {
        debugPrint("❌ Authentication error: $message");
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
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

// Custom loading screen with better proportions
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3E8728)),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
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
    
    if (state == AppLifecycleState.resumed) {
      debugPrint("📱 App resumed - checking session validity");
      _checkSessionOnResume();
    }
  }

  Future<void> _checkSessionOnResume() async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    if (authNotifier.isAuthenticated) {
      try {
        debugPrint("✅ Session check passed");
      } catch (e) {
        debugPrint("❌ Session check failed: $e");
        await authNotifier.refreshSession();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentIndexProvider);

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvoked: (didPop) {
        if (!didPop && currentIndex != 0) {
          ref.read(currentIndexProvider.notifier).state = 0;
        }
      },
      child: Scaffold(
        extendBody: false,
        body: IndexedStack(
          index: currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}