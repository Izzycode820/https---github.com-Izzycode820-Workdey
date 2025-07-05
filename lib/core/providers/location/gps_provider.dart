// enhanced_gps_location_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/location/gps_service.dart';

// Enhanced GPS Service Provider
final enhancedGpsServiceProvider = Provider<EnhancedGPSLocationService>((ref) {
  return EnhancedGPSLocationService(
    ref.read(dioProvider), 
    ref.read(localCacheProvider)
  );
});

// Enhanced GPS Location Provider with detailed state management
final enhancedGpsLocationProvider = StateNotifierProvider<EnhancedGPSLocationNotifier, EnhancedGPSLocationState>((ref) {
  return EnhancedGPSLocationNotifier(ref.read(enhancedGpsServiceProvider));
});

// Nearby Jobs Provider using GPS
final nearbyJobsProvider = FutureProvider.family<List<Job>, double>((ref, radius) async {
  final service = ref.read(enhancedGpsServiceProvider);
  return await service.getNearbyJobs(radius: radius);
});

// Smart Nearby Jobs Provider
final smartNearbyJobsProvider = FutureProvider<List<Job>>((ref) async {
  final service = ref.read(enhancedGpsServiceProvider);
  return await service.getSmartNearbyJobs();
});

// Location Permission Status Provider
final locationPermissionProvider = FutureProvider<LocationPermissionResult>((ref) async {
  final service = ref.read(enhancedGpsServiceProvider);
  return await service.requestLocationPermission();
});

class EnhancedGPSLocationState {
  final Position? currentPosition;
  final bool isLoading;
  final String? errorMessage;
  final LocationError? errorType;
  final DateTime? lastUpdate;
  final LocationPermissionStatus permissionStatus;
  final bool isLocationServiceEnabled;
  final double? accuracy;
  final bool isInCameroon;

  const EnhancedGPSLocationState({
    this.currentPosition,
    this.isLoading = false,
    this.errorMessage,
    this.errorType,
    this.lastUpdate,
    this.permissionStatus = LocationPermissionStatus.unknown,
    this.isLocationServiceEnabled = false,
    this.accuracy,
    this.isInCameroon = false,
  });

  bool get hasPosition => currentPosition != null;
  bool get hasPermission => permissionStatus == LocationPermissionStatus.granted;
  bool get canRequestPermission => permissionStatus != LocationPermissionStatus.deniedForever;
  bool get isReady => hasPosition && hasPermission && isLocationServiceEnabled;
  
  String get statusMessage {
    if (isLoading) return 'Getting your location...';
    if (!isLocationServiceEnabled) return 'Location services disabled';
    if (!hasPermission) return 'Location permission required';
    if (!isInCameroon) return 'Location outside Cameroon';
    if (hasPosition) return 'GPS active - accuracy ${accuracy?.toStringAsFixed(0)}m';
    return 'Location unavailable';
  }

  EnhancedGPSLocationState copyWith({
    Position? currentPosition,
    bool? isLoading,
    String? errorMessage,
    LocationError? errorType,
    DateTime? lastUpdate,
    LocationPermissionStatus? permissionStatus,
    bool? isLocationServiceEnabled,
    double? accuracy,
    bool? isInCameroon,
  }) {
    return EnhancedGPSLocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      errorType: errorType,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      permissionStatus: permissionStatus ?? this.permissionStatus,
      isLocationServiceEnabled: isLocationServiceEnabled ?? this.isLocationServiceEnabled,
      accuracy: accuracy ?? this.accuracy,
      isInCameroon: isInCameroon ?? this.isInCameroon,
    );
  }

  EnhancedGPSLocationState clearError() {
    return copyWith(
      errorMessage: null,
      errorType: null,
    );
  }
}

class EnhancedGPSLocationNotifier extends StateNotifier<EnhancedGPSLocationState> {
  final EnhancedGPSLocationService _gpsService;
  
  EnhancedGPSLocationNotifier(this._gpsService) : super(const EnhancedGPSLocationState()) {
    _initializeLocationStatus();
  }

  // Initialize location status on startup
  Future<void> _initializeLocationStatus() async {
    try {
      // Check if location service is enabled
      final isServiceEnabled = await _gpsService.isLocationServiceEnabled();
      
      state = state.copyWith(
        isLocationServiceEnabled: isServiceEnabled,
      );

      if (isServiceEnabled) {
        // Check permission status
        await checkPermissionStatus();
      }
    } catch (e) {
      debugPrint('Error initializing location status: $e');
    }
  }

  // Check current permission status without requesting
  Future<void> checkPermissionStatus() async {
    try {
      final permission = await Geolocator.checkPermission();
      final status = _mapPermissionToStatus(permission);
      
      state = state.copyWith(
        permissionStatus: status,
      );
    } catch (e) {
      debugPrint('Error checking permission status: $e');
    }
  }

  // Request location permission and get current location
  Future<void> requestLocationAndUpdate() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      errorType: null,
    );

    try {
      final result = await _gpsService.getCurrentLocation(forceRefresh: true);
      
      if (result.isSuccess && result.position != null) {
        final position = result.position!;
        final isInCameroon = _isInCameroon(position.latitude, position.longitude);
        
        state = state.copyWith(
          currentPosition: position,
          isLoading: false,
          lastUpdate: DateTime.now(),
          permissionStatus: LocationPermissionStatus.granted,
          isLocationServiceEnabled: true,
          accuracy: position.accuracy,
          isInCameroon: isInCameroon,
        );

        debugPrint('✅ Location updated: ${position.latitude}, ${position.longitude}');
      } else {
        _handleLocationError(result);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unexpected error: $e',
        errorType: LocationError.unknown,
      );
      debugPrint('❌ Location request error: $e');
    }
  }

  // Refresh current location (if permission already granted)
  Future<void> refreshLocation() async {
    if (!state.hasPermission) {
      await requestLocationAndUpdate();
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final result = await _gpsService.getCurrentLocation(forceRefresh: true);
      
      if (result.isSuccess && result.position != null) {
        final position = result.position!;
        final isInCameroon = _isInCameroon(position.latitude, position.longitude);
        
        state = state.copyWith(
          currentPosition: position,
          isLoading: false,
          lastUpdate: DateTime.now(),
          accuracy: position.accuracy,
          isInCameroon: isInCameroon,
          errorMessage: null,
          errorType: null,
        );
      } else {
        _handleLocationError(result);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to refresh location: $e',
        errorType: LocationError.unknown,
      );
    }
  }

  // Open device location settings
  Future<void> openLocationSettings() async {
    try {
      await _gpsService.openLocationSettings();
      // Re-check status after user returns
      await Future.delayed(const Duration(seconds: 1));
      await _initializeLocationStatus();
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Could not open location settings: $e',
        errorType: LocationError.unknown,
      );
    }
  }

  // Clear any error state
  void clearError() {
    state = state.clearError();
  }

  // Get nearby jobs using current location
  Future<List<Job>> getNearbyJobs({double radius = 15.0}) async {
    if (!state.isReady) {
      throw Exception('GPS location not ready. Status: ${state.statusMessage}');
    }

    try {
      return await _gpsService.getNearbyJobs(radius: radius);
    } catch (e) {
      debugPrint('Error getting nearby jobs: $e');
      rethrow;
    }
  }

  // Get smart nearby jobs using AI matching
  Future<List<Job>> getSmartNearbyJobs() async {
    if (!state.isReady) {
      throw Exception('GPS location not ready. Status: ${state.statusMessage}');
    }

    try {
      return await _gpsService.getSmartNearbyJobs();
    } catch (e) {
      debugPrint('Error getting smart nearby jobs: $e');
      rethrow;
    }
  }

  // Helper methods
  void _handleLocationError(LocationResult result) {
    LocationPermissionStatus? permissionStatus;
    LocationError? errorType = result.error;

    // Map specific errors to permission status
    switch (result.error) {
      case LocationError.permissionDenied:
        permissionStatus = LocationPermissionStatus.denied;
        break;
      case LocationError.serviceDisabled:
        state = state.copyWith(isLocationServiceEnabled: false);
        break;
      default:
        break;
    }

    state = state.copyWith(
      isLoading: false,
      errorMessage: result.message,
      errorType: errorType,
      permissionStatus: permissionStatus ?? state.permissionStatus,
    );
  }

  LocationPermissionStatus _mapPermissionToStatus(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return LocationPermissionStatus.granted;
      case LocationPermission.denied:
        return LocationPermissionStatus.denied;
      case LocationPermission.deniedForever:
        return LocationPermissionStatus.deniedForever;
      case LocationPermission.unableToDetermine:
        return LocationPermissionStatus.unknown;
    }
  }

  bool _isInCameroon(double lat, double lng) {
    return lat >= 2.0 && lat <= 13.0 && lng >= 8.0 && lng <= 16.5;
  }
}

// Additional status enum
enum LocationPermissionStatus {
  unknown,
  granted,
  denied,
  deniedForever,
}