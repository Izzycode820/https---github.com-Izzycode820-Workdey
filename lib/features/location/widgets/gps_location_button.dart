import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workdey_frontend/core/providers/location/gps_provider.dart';

class GPSLocationButton extends ConsumerWidget {
  final Function(Position)? onLocationObtained;
  final bool showAccuracy;

  const GPSLocationButton({
    super.key,
    this.onLocationObtained,
    this.showAccuracy = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gpsState = ref.watch(enhancedGpsLocationProvider);

    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: gpsState.isLoading 
              ? null 
              : () => _requestLocation(ref),
          icon: gpsState.isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  gpsState.hasPermission ? Icons.gps_fixed : Icons.gps_off,
                  color: gpsState.hasPermission ? Colors.green : Colors.grey,
                ),
          label: Text(_getButtonText(gpsState)),
          style: ElevatedButton.styleFrom(
            backgroundColor: gpsState.hasPermission ? Colors.green[50] : null,
            foregroundColor: gpsState.hasPermission ? Colors.green[700] : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        
        if (showAccuracy && gpsState.currentPosition != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _buildLocationInfo(gpsState.currentPosition!, gpsState.lastUpdate),
          ),
          
        if (gpsState.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              gpsState.errorMessage!,
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  String _getButtonText(EnhancedGPSLocationState state) {
    if (state.isLoading) return 'Getting location...';
    if (state.currentPosition != null) return 'Update location';
    if (state.hasPermission) return 'Get my location';
    return 'Enable GPS';
  }

  Widget _buildLocationInfo(Position position, DateTime? lastUpdate) {
  final accuracy = position.accuracy;
  final updateTime = _formatLastUpdate(lastUpdate); // Use helper instead of timeago

  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.green[50],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.green[200]!),
    ),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.green[700]),
            const SizedBox(width: 4),
            Text(
              'Accuracy: ${accuracy.toStringAsFixed(0)}m',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          'Updated $updateTime',
          style: TextStyle(
            fontSize: 10,
            color: Colors.green[600],
          ),
        ),
      ],
    ),
  );
}

String _formatLastUpdate(DateTime? lastUpdate) {
  if (lastUpdate == null) return 'Unknown';
  
  final now = DateTime.now();
  final difference = now.difference(lastUpdate);
  
  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  } else {
    return '${difference.inDays}d ago';
  }
}

  Future<void> _requestLocation(WidgetRef ref) async {
    await ref.read(enhancedGpsLocationProvider.notifier).requestLocationAndUpdate();
    
    final state = ref.read(enhancedGpsLocationProvider);
    if (state.currentPosition != null && onLocationObtained != null) {
      onLocationObtained!(state.currentPosition!);
    }
  }
}