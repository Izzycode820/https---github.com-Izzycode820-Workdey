import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:workdey_frontend/core/models/location/locationzone/location_zone_model.dart';
import 'package:workdey_frontend/core/models/location/userlocaton_preference/user_location_preference_model.dart';
import 'package:workdey_frontend/core/storage/local_cache.dart';

class LocationService {
  final Dio _dio;
  final LocalCache _cache;

  LocationService(this._dio, this._cache);

  // Zone Management
  Future<List<LocationZone>> getPopularZones() async {
    try {
      final cached = await _cache.get('popular_zones');
      if (cached != null) {
        // Handle both direct list and paginated response
        final List<dynamic> zonesList = cached is List 
            ? cached 
            : (cached['results'] ?? cached);
        return zonesList.map((e) => LocationZone.fromJson(e)).toList();
      }

      final response = await _dio.get('/api/v1/zones/popular/');
      
      // ✅ Handle paginated response
      final List<dynamic> zonesData;
      if (response.data is List) {
        zonesData = response.data;
      } else if (response.data is Map && response.data['results'] != null) {
        zonesData = response.data['results'];
      } else {
        debugPrint('Unexpected popular zones response format: ${response.data}');
        return [];
      }
      
      final zones = zonesData.map((e) => LocationZone.fromJson(e)).toList();
      
      await _cache.set('popular_zones', zonesData, duration: Duration(hours: 6));
      return zones;
    } catch (e) {
      debugPrint('Error fetching popular zones: $e');
      return [];
    }
  }

  Future<List<LocationZone>> searchZones(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final response = await _dio.get('/api/v1/zones/', queryParameters: {
        'search': query,
      });
      
      debugPrint('🔍 Zone search response: ${response.data}'); // Debug log
      
      // ✅ Handle both paginated and direct list responses
      final List<dynamic> zonesData;
      if (response.data is List) {
        // Direct list response
        zonesData = response.data;
      } else if (response.data is Map) {
        // Paginated response
        if (response.data['results'] != null) {
          zonesData = response.data['results'];
        } else {
          debugPrint('No results field in paginated response');
          return [];
        }
      } else {
        debugPrint('Unexpected zone search response format: ${response.data}');
        return [];
      }
      
      return zonesData.map((e) => LocationZone.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error searching zones: $e');
      debugPrint('Error details: ${e.toString()}');
      return [];
    }
  }

  Future<List<LocationZone>> suggestZonesFromLocation(String location) async {
    try {
      final response = await _dio.post('/api/v1/zones/suggest/', data: {
        'location': location,
      });
      
      debugPrint('💡 Zone suggestions response: ${response.data}'); // Debug log
      
      // ✅ Handle response format
      final List<dynamic> zonesData;
      if (response.data is List) {
        zonesData = response.data;
      } else if (response.data is Map && response.data['results'] != null) {
        zonesData = response.data['results'];
      } else {
        debugPrint('Unexpected suggestions response format: ${response.data}');
        return [];
      }
      
      return zonesData.map((e) => LocationZone.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error getting zone suggestions: $e');
      return [];
    }
  }

  // User Location Preferences
  Future<UserLocationPreference?> getUserLocationPreferences() async {
    try {
      final response = await _dio.get('/api/v1/location_preferences/me/');
      return UserLocationPreference.fromJson(response.data);
    } catch (e) {
      debugPrint('Error fetching location preferences: $e');
      return null;
    }
  }

  Future<UserLocationPreference?> updateLocationPreferences(
    Map<String, dynamic> preferences
  ) async {
    try {
      final response = await _dio.patch('/api/v1/location-preferences/me/', data: preferences);
      return UserLocationPreference.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating location preferences: $e');
      rethrow;
    }
  }
}