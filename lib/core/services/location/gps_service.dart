// enhanced_gps_location_service.dart
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/storage/local_cache.dart';

class EnhancedGPSLocationService {
  final Dio _dio;
  final LocalCache _cache;
  
  static const String _cacheKey = 'last_gps_location';
  static const String _permissionStatusKey = 'gps_permission_status';
  static const Duration _locationUpdateInterval = Duration(minutes: 5);
  static const Duration _cacheExpiry = Duration(hours: 2);

  EnhancedGPSLocationService(this._dio, this._cache);

  // ================== PERMISSION MANAGEMENT ==================

  /// Comprehensive permission handling with detailed status
  Future<LocationPermissionResult> requestLocationPermission() async {
    try {
      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();
      debugPrint('📍 Current GPS permission: $permission');

      // Handle different permission states
      switch (permission) {
        case LocationPermission.denied:
          debugPrint('📍 Requesting GPS permission...');
          permission = await Geolocator.requestPermission();
          break;
          
        case LocationPermission.deniedForever:
          debugPrint('❌ GPS permission permanently denied');
          return LocationPermissionResult(
            status: LocationPermissionStatus.deniedForever,
            message: 'Location permission permanently denied. Enable in phone settings.',
            canRequest: false,
          );
          
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          debugPrint('✅ GPS permission already granted: $permission');
          return LocationPermissionResult(
            status: LocationPermissionStatus.granted,
            message: 'Location permission granted',
            canRequest: true,
          );
          
        case LocationPermission.unableToDetermine:
          debugPrint('⚠️ Unable to determine GPS permission status');
          return LocationPermissionResult(
            status: LocationPermissionStatus.error,
            message: 'Unable to determine location permission status',
            canRequest: false,
          );
      }

      // Handle the response from permission request
      switch (permission) {
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          await _cache.set(_permissionStatusKey, 'granted');
          return LocationPermissionResult(
            status: LocationPermissionStatus.granted,
            message: 'Location permission granted successfully',
            canRequest: true,
          );
          
        case LocationPermission.denied:
          await _cache.set(_permissionStatusKey, 'denied');
          return LocationPermissionResult(
            status: LocationPermissionStatus.denied,
            message: 'Location permission denied. Tap to try again.',
            canRequest: true,
          );
          
        case LocationPermission.deniedForever:
          await _cache.set(_permissionStatusKey, 'denied_forever');
          return LocationPermissionResult(
            status: LocationPermissionStatus.deniedForever,
            message: 'Open phone settings to enable location access.',
            canRequest: false,
          );
          
        default:
          return LocationPermissionResult(
            status: LocationPermissionStatus.error,
            message: 'Unexpected permission state',
            canRequest: false,
          );
      }
    } catch (e) {
      debugPrint('❌ GPS permission error: $e');
      return LocationPermissionResult(
        status: LocationPermissionStatus.error,
        message: 'Error requesting location permission: $e',
        canRequest: false,
      );
    }
  }

  /// Check if location services are enabled on device
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      debugPrint('❌ Error checking location service: $e');
      return false;
    }
  }

  /// Open device location settings
  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
    } catch (e) {
      debugPrint('❌ Error opening location settings: $e');
      // Fallback to general app settings
      await Permission.location.request();
    }
  }

  // ================== LOCATION ACQUISITION ==================

  /// Get current location with advanced error handling and caching
  Future<LocationResult> getCurrentLocation({
    bool forceRefresh = false,
    double? desiredAccuracy,
  }) async {
    try {
      debugPrint('📍 Getting current location (forceRefresh: $forceRefresh)');

      // Check cached location first if not forcing refresh
      if (!forceRefresh) {
        final cachedLocation = await _getCachedLocation();
        if (cachedLocation != null) {
          debugPrint('✅ Using cached location');
          return LocationResult.success(cachedLocation);
        }
      }

      // Check permissions
      final permissionResult = await requestLocationPermission();
      if (permissionResult.status != LocationPermissionStatus.granted) {
        return LocationResult.permissionDenied(permissionResult.message);
      }

      // Check if location service is enabled
      if (!await isLocationServiceEnabled()) {
        return LocationResult.serviceDisabled(
          'Location services are disabled. Enable in phone settings.'
        );
      }

      // Configure location settings based on accuracy needs
      late LocationSettings locationSettings;
      
      if (defaultTargetPlatform == TargetPlatform.android) {
        locationSettings = AndroidSettings(
          accuracy: desiredAccuracy != null 
              ? LocationAccuracy.best 
              : LocationAccuracy.high,
          distanceFilter: 10, // Update every 10 meters
          forceLocationManager: false, // Use Google Play Services
          intervalDuration: _locationUpdateInterval,
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        locationSettings = AppleSettings(
          accuracy: desiredAccuracy != null 
              ? LocationAccuracy.best 
              : LocationAccuracy.high,
          activityType: ActivityType.other,
          distanceFilter: 10,
          pauseLocationUpdatesAutomatically: true,
          showBackgroundLocationIndicator: false,
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        );
      }

      debugPrint('📍 Acquiring GPS position...');
      
      // Get location with timeout
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy != null 
            ? LocationAccuracy.best 
            : LocationAccuracy.high,
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException(
          'Location request timed out after 15 seconds',
          const Duration(seconds: 15),
        ),
      );

      // Validate Cameroon bounds
      if (!_isInCameroon(position.latitude, position.longitude)) {
        debugPrint('⚠️ Location outside Cameroon bounds');
        return LocationResult.outOfBounds(
          'Location appears to be outside Cameroon. Please check your GPS settings.'
        );
      }

      // Cache the location
      await _cacheLocation(position);
      
      // Update backend
      await _updateBackendLocation(position);

      debugPrint('✅ Location acquired successfully: ${position.latitude}, ${position.longitude}');
      return LocationResult.success(position);

    } on TimeoutException catch (e) {
      debugPrint('⏱️ GPS timeout: $e');
      return LocationResult.timeout('GPS is taking too long. Please try again.');
      
    } on LocationServiceDisabledException catch (e) {
      debugPrint('❌ Location service disabled: $e');
      return LocationResult.serviceDisabled(
        'Location services are disabled. Enable them in settings.'
      );
      
    } on PermissionDeniedException catch (e) {
      debugPrint('❌ Permission denied: $e');
      return LocationResult.permissionDenied(
        'Location permission denied. Grant permission to find nearby jobs.'
      );
      
    } catch (e) {
      debugPrint('❌ GPS error: $e');
      return LocationResult.error('Failed to get location: $e');
    }
  }

  /// Stream location updates for real-time tracking
  Stream<LocationResult> getLocationStream({
    Duration? interval,
    double? distanceFilter,
  }) async* {
    try {
      // Check permissions first
      final permissionResult = await requestLocationPermission();
      if (permissionResult.status != LocationPermissionStatus.granted) {
        yield LocationResult.permissionDenied(permissionResult.message);
        return;
      }

      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50, // Update every 50 meters
      );

      await for (final position in Geolocator.getPositionStream(
        locationSettings: locationSettings,
      )) {
        if (_isInCameroon(position.latitude, position.longitude)) {
          await _cacheLocation(position);
          yield LocationResult.success(position);
        } else {
          yield LocationResult.outOfBounds(
            'Location outside Cameroon bounds'
          );
        }
      }
    } catch (e) {
      yield LocationResult.error('Location stream error: $e');
    }
  }

  // ================== JOB SEARCH INTEGRATION ==================

  /// Get nearby jobs using GPS with fallback strategies
  Future<List<Job>> getNearbyJobs({
    double radius = 15.0,
    bool useCache = true,
  }) async {
    try {
      debugPrint('🔍 Getting nearby jobs (radius: ${radius}km)');

      // Get current location
      final locationResult = await getCurrentLocation();
      if (!locationResult.isSuccess) {
        debugPrint('❌ Cannot get nearby jobs: ${locationResult.message}');
        return [];
      }

      final position = locationResult.position!;

      // Make API request
      final response = await _dio.get('/api/v1/gps/nearby_jobs_gps/', 
        queryParameters: {
          'radius': radius,
        },
      );

      final jobsData = response.data['jobs'] as List;
      final jobs = jobsData.map((e) => Job.fromJson(e)).toList();

      debugPrint('✅ Found ${jobs.length} nearby jobs');
      
      // Cache results
      if (useCache) {
        await _cache.set('nearby_jobs_${radius}km', jobsData, 
          duration: const Duration(minutes: 30));
      }

      return jobs;
      
    } catch (e) {
      debugPrint('❌ Error getting nearby jobs: $e');
      
      // Try cached results as fallback
      if (useCache) {
        final cached = await _cache.get('nearby_jobs_${radius}km');
        if (cached != null) {
          debugPrint('✅ Using cached nearby jobs');
          return (cached as List).map((e) => Job.fromJson(e)).toList();
        }
      }
      
      return [];
    }
  }

  /// Get smart nearby jobs (GPS + AI matching)
  Future<List<Job>> getSmartNearbyJobs() async {
    try {
      final response = await _dio.get('/api/v1/gps/smart_nearby/');
      final jobsData = response.data['jobs'] as List;
      return jobsData.map((e) => Job.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error getting smart nearby jobs: $e');
      return [];
    }
  }

  // ================== PRIVATE HELPER METHODS ==================

  bool _isInCameroon(double lat, double lng) {
    // Cameroon bounds: Lat 2.0-13.0, Lng 8.0-16.5
    return lat >= 2.0 && lat <= 13.0 && lng >= 8.0 && lng <= 16.5;
  }

  Future<Position?> _getCachedLocation() async {
    try {
      final cached = await _cache.get(_cacheKey);
      if (cached == null) return null;

      final timestamp = DateTime.parse(cached['timestamp']);
      if (DateTime.now().difference(timestamp) > _cacheExpiry) {
        await _cache.remove(_cacheKey);
        return null;
      }

      return Position(
         latitude: cached['latitude'],
        longitude: cached['longitude'],
        accuracy: cached['accuracy'],
        altitude: cached['altitude'] ?? 0.0,
        altitudeAccuracy: cached['altitudeAccuracy'] ?? 0.0,
        heading: cached['heading'] ?? 0.0,
        headingAccuracy: cached['headingAccuracy'] ?? 0.0,
        speed: cached['speed'] ?? 0.0,
        speedAccuracy: cached['speedAccuracy'] ?? 0.0,
        timestamp: timestamp,
      );
    } catch (e) {
      debugPrint('Error getting cached location: $e');
      return null;
    }
  }

  Future<void> _cacheLocation(Position position) async {
    await _cache.set(_cacheKey, {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'accuracy': position.accuracy,
      'altitude': position.altitude,
      'altitudeAccuracy': position.altitudeAccuracy,
      'heading': position.heading,
      'headingAccuracy': position.headingAccuracy,
      'speed': position.speed,
      'speedAccuracy': position.speedAccuracy,
      'timestamp': position.timestamp.toIso8601String(),
    }, duration: _cacheExpiry);
  }

  Future<void> _updateBackendLocation(Position position) async {
    try {
      await _dio.post('/api/v1/gps/update_location/', data: {
        'latitude': position.latitude,
        'longitude': position.longitude,
      });
      debugPrint('✅ Backend location updated');
    } catch (e) {
      debugPrint('❌ Backend location update failed: $e');
      // Don't throw - this is not critical for user experience
    }
  }
}

// ================== RESULT CLASSES ==================

class LocationResult {
  final bool isSuccess;
  final Position? position;
  final String? message;
  final LocationError? error;

  LocationResult._({
    required this.isSuccess,
    this.position,
    this.message,
    this.error,
  });

  factory LocationResult.success(Position position) => LocationResult._(
    isSuccess: true,
    position: position,
  );

  factory LocationResult.permissionDenied(String message) => LocationResult._(
    isSuccess: false,
    message: message,
    error: LocationError.permissionDenied,
  );

  factory LocationResult.serviceDisabled(String message) => LocationResult._(
    isSuccess: false,
    message: message,
    error: LocationError.serviceDisabled,
  );

  factory LocationResult.timeout(String message) => LocationResult._(
    isSuccess: false,
    message: message,
    error: LocationError.timeout,
  );

  factory LocationResult.outOfBounds(String message) => LocationResult._(
    isSuccess: false,
    message: message,
    error: LocationError.outOfBounds,
  );

  factory LocationResult.error(String message) => LocationResult._(
    isSuccess: false,
    message: message,
    error: LocationError.unknown,
  );
}

class LocationPermissionResult {
  final LocationPermissionStatus status;
  final String message;
  final bool canRequest;

  LocationPermissionResult({
    required this.status,
    required this.message,
    required this.canRequest,
  });
}

enum LocationPermissionStatus {
  granted,
  denied,
  deniedForever,
  error,
}

enum LocationError {
  permissionDenied,
  serviceDisabled,
  timeout,
  outOfBounds,
  unknown,
}