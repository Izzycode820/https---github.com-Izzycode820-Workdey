// Zone selection state
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/location/locationzone/location_zone_model.dart';
import 'package:workdey_frontend/core/models/location/userlocaton_preference/user_location_preference_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/location/location_service.dart';

final zoneSearchProvider = StateNotifierProvider<ZoneSearchNotifier, ZoneSearchState>((ref) {
  return ZoneSearchNotifier(ref.read(locationServiceProvider));
});

class ZoneSearchState {
  final List<LocationZone> zones;
  final bool isLoading;
  final String? error;
  final String query;

  ZoneSearchState({
    this.zones = const [],
    this.isLoading = false,
    this.error,
    this.query = '',
  });

  ZoneSearchState copyWith({
    List<LocationZone>? zones,
    bool? isLoading,
    String? error,
    String? query,
  }) {
    return ZoneSearchState(
      zones: zones ?? this.zones,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      query: query ?? this.query,
    );
  }
}

class ZoneSearchNotifier extends StateNotifier<ZoneSearchState> {
  final LocationService _locationService;
  Timer? _debounceTimer;

  ZoneSearchNotifier(this._locationService) : super(ZoneSearchState());

  void searchZones(String query) {
    _debounceTimer?.cancel();
    
    if (query.isEmpty) {
      state = state.copyWith(zones: [], query: query);
      return;
    }

    state = state.copyWith(isLoading: true, query: query);

    _debounceTimer = Timer(Duration(milliseconds: 500), () async {
      try {
        final zones = await _locationService.searchZones(query);
        state = state.copyWith(
          zones: zones,
          isLoading: false,
          error: null,
        );
      } catch (e) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
          zones: [],
        );
      }
    });
  }

  void clearSearch() {
    state = ZoneSearchState();
    _debounceTimer?.cancel();
  }
}

// User location preferences
final locationPreferencesProvider = StateNotifierProvider<LocationPreferencesNotifier, AsyncValue<UserLocationPreference?>>((ref) {
  return LocationPreferencesNotifier(ref.read(locationServiceProvider));
});

class LocationPreferencesNotifier extends StateNotifier<AsyncValue<UserLocationPreference?>> {
  final LocationService _locationService;

  LocationPreferencesNotifier(this._locationService) : super(const AsyncValue.loading());

  Future<void> loadPreferences() async {
    try {
      state = const AsyncValue.loading();
      final prefs = await _locationService.getUserLocationPreferences();
      state = AsyncValue.data(prefs);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateHomeZone(LocationZone zone) async {
    try {
      final updated = await _locationService.updateLocationPreferences({
        'home_zone_id': zone.id,
      });
      if (updated != null) {
        state = AsyncValue.data(updated);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateTravelPreferences({
    int? maxTravelTime,
    int? maxTransportCost,
    List<String>? preferredTransport,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (maxTravelTime != null) data['max_travel_time'] = maxTravelTime;
      if (maxTransportCost != null) data['max_transport_cost'] = maxTransportCost;
      if (preferredTransport != null) data['preferred_transport'] = preferredTransport;

      final updated = await _locationService.updateLocationPreferences(data);
      if (updated != null) {
        state = AsyncValue.data(updated);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}