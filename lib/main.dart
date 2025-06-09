import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workdey_frontend/app.dart';
import 'package:workdey_frontend/core/routes/route_generator.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
 
  // System UI styling
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
    ),
  );

  runApp(
    ProviderScope(
    child: DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const WorkdeyApp(),
      ),
    ),
  );
}

class WorkdeyApp extends StatelessWidget {
  const WorkdeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: DevicePreview.appBuilder,
      title: 'Workdey',
      debugShowCheckedModeBanner: false,
      theme: _buildWorkdeyTheme(),
      darkTheme: _buildDarkTheme(),
      home: const App(),
      onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (_) => const Scaffold(
      body: Center(child: Text("Route not found!")),
  ),
)
    );
  }

ThemeData _buildWorkdeyTheme() {
  const primaryGreen = Color(0xFF3E8728);
  const secondaryGreen = Color(0xFF07864B);
  const backgroundGray = Color(0xFFF5F7FC);
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
    //for errors
    /*inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(color: Colors.red[700]), // Error text style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      // Add these if you want more customization:
      labelStyle: TextStyle(color: const Color.fromARGB(255, 14, 12, 12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color(0xFF3E8728)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),*/
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
}}