// enhanced_job_listing_headers.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class EnhancedJobListingHeader extends ConsumerWidget {
  final JobListingType listingType;
  final int jobCount;
  final String? city;
  final String? district;
  final Position? userLocation;
  final double? searchRadius;
  final bool isLoading;

  const EnhancedJobListingHeader({
    super.key,
    required this.listingType,
    required this.jobCount,
    this.city,
    this.district,
    this.userLocation,
    this.searchRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getPrimaryColor().withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIcon(),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTitle(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getSubtitle(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Location & Stats Row
          Row(
            children: [
              // Location Info
              Expanded(
                child: _buildLocationInfo(),
              ),
              const SizedBox(width: 16),
              // Job Count Badge
              _buildJobCountBadge(),
            ],
          ),
          
          // Additional Info Row
          if (_shouldShowAdditionalInfo())
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _buildAdditionalInfo(),
            ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (listingType) {
      case JobListingType.nearbyGPS:
        return "Jobs Near You";
      case JobListingType.smartNearby:
        return "Perfect Matches";
      case JobListingType.cityLocation:
        return "Jobs in $city";
      case JobListingType.districtLocation:
        return "Local Jobs";
      case JobListingType.general:
        return "All Available Jobs";
      case JobListingType.saved:
        return "Your Saved Jobs";
      case JobListingType.applied:
        return "Applications";
      case JobListingType.posted:
        return "Your Posted Jobs";
    }
  }

  String _getSubtitle() {
    switch (listingType) {
      case JobListingType.nearbyGPS:
        return "Based on your current location";
      case JobListingType.smartNearby:
        return "Tailored to your preferences";
      case JobListingType.cityLocation:
        return district != null ? "In $district district" : "City-wide opportunities";
      case JobListingType.districtLocation:
        return "In your selected area";
      case JobListingType.general:
        return "Explore opportunities everywhere";
      case JobListingType.saved:
        return "Jobs you've bookmarked";
      case JobListingType.applied:
        return "Track your applications";
      case JobListingType.posted:
        return "Manage your job posts";
    }
  }

  IconData _getIcon() {
    switch (listingType) {
      case JobListingType.nearbyGPS:
        return Icons.my_location;
      case JobListingType.smartNearby:
        return Icons.psychology;
      case JobListingType.cityLocation:
        return Icons.location_city;
      case JobListingType.districtLocation:
        return Icons.location_on;
      case JobListingType.general:
        return Icons.work;
      case JobListingType.saved:
        return Icons.bookmark;
      case JobListingType.applied:
        return Icons.assignment_turned_in;
      case JobListingType.posted:
        return Icons.post_add;
    }
  }

  Color _getPrimaryColor() {
    switch (listingType) {
      case JobListingType.nearbyGPS:
        return const Color(0xFF2196F3); // Blue
      case JobListingType.smartNearby:
        return const Color(0xFF9C27B0); // Purple
      case JobListingType.cityLocation:
        return const Color(0xFF3E8728); // Green
      case JobListingType.districtLocation:
        return const Color(0xFF00BCD4); // Cyan
      case JobListingType.general:
        return const Color(0xFF607D8B); // Blue Grey
      case JobListingType.saved:
        return const Color(0xFFFF9800); // Orange
      case JobListingType.applied:
        return const Color(0xFF4CAF50); // Light Green
      case JobListingType.posted:
        return const Color(0xFF673AB7); // Deep Purple
    }
  }

  LinearGradient _getGradient() {
    final primary = _getPrimaryColor();
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primary,
        primary.withOpacity(0.8),
      ],
    );
  }

  Widget _buildLocationInfo() {
    late IconData icon;
    late String text;
    late String detail;

    switch (listingType) {
      case JobListingType.nearbyGPS:
        icon = Icons.gps_fixed;
        text = searchRadius != null 
            ? "Within ${searchRadius!.toStringAsFixed(0)}km"
            : "GPS Location";
        detail = "Real-time positioning";
        break;
      case JobListingType.smartNearby:
        icon = Icons.smart_toy;
        text = "AI-Powered";
        detail = "Matches your profile";
        break;
      case JobListingType.cityLocation:
      case JobListingType.districtLocation:
        icon = Icons.place;
        text = district != null ? "$city, $district" : city ?? "Selected Area";
        detail = "Manual location search";
        break;
      default:
        icon = Icons.explore;
        text = "All Locations";
        detail = "No location filter";
    }

    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                detail,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJobCountBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            jobCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            jobCount == 1 ? "Job" : "Jobs",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  bool _shouldShowAdditionalInfo() {
    return listingType == JobListingType.nearbyGPS || 
           listingType == JobListingType.smartNearby;
  }

  Widget _buildAdditionalInfo() {
    if (listingType == JobListingType.nearbyGPS) {
      return _buildGPSAccuracyInfo();
    } else if (listingType == JobListingType.smartNearby) {
      return _buildSmartMatchInfo();
    }
    return const SizedBox.shrink();
  }

  Widget _buildGPSAccuracyInfo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.white.withOpacity(0.8), size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              userLocation != null 
                  ? "Accuracy: ${userLocation!.accuracy.toStringAsFixed(0)}m • Updated ${_formatLastUpdate()}"
                  : "Enable GPS for best results",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartMatchInfo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: Colors.white.withOpacity(0.8), size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Combines GPS, travel preferences, and job history",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastUpdate() {
    // You'd implement this based on your last GPS update time
    return "2m ago";
  }
}

enum JobListingType {
  nearbyGPS,
  smartNearby,
  cityLocation,
  districtLocation,
  general,
  saved,
  applied,
  posted,
}