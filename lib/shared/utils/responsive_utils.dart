import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  
  // LinkedIn-style spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  
  // LinkedIn-style border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  
  // LinkedIn-style elevations
  static const double elevationLow = 1.0;
  static const double elevationMedium = 2.0;
  static const double elevationHigh = 4.0;
  
  // Get responsive font sizes
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Base width (typical phone width)
    const baseWidth = 375.0;
    
    // Calculate scale factor
    final scaleFactor = (screenWidth / baseWidth).clamp(0.8, 1.2);
    
    return baseSize * scaleFactor;
  }
  
  // Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      // Mobile
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    } else if (screenWidth < 1200) {
      // Tablet
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    } else {
      // Desktop
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }
  
  // Get responsive card width
  static double getCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return screenWidth - 32; // Mobile: full width with margin
    } else if (screenWidth < 1200) {
      return 400; // Tablet: fixed width
    } else {
      return 450; // Desktop: larger fixed width
    }
  }
  
  // Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  
  // Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }
  
  // Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
}

// Extension for easy access to responsive utils
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;
}

// Custom widgets for consistent styling
class WorkdeyCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? elevation;
  final VoidCallback? onTap;
  
  const WorkdeyCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.elevation,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? ResponsiveUtils.getResponsivePadding(context),
      child: Material(
        elevation: elevation ?? ResponsiveUtils.elevationMedium,
        borderRadius: BorderRadius.circular(ResponsiveUtils.radiusMedium),
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ResponsiveUtils.radiusMedium),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(ResponsiveUtils.spacing16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class WorkdeyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final EdgeInsets? padding;
  
  const WorkdeyButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.padding,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.grey[100] : const Color(0xFF3E8728),
          foregroundColor: isSecondary ? Colors.black87 : Colors.white,
          elevation: ResponsiveUtils.elevationMedium,
          padding: padding ?? const EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.spacing24,
            vertical: ResponsiveUtils.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveUtils.radiusMedium),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}