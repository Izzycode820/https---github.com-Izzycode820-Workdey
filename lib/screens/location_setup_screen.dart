import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workdey_frontend/core/models/location/locationzone/location_zone_model.dart';
import 'package:workdey_frontend/core/providers/location/location_provider.dart';
import 'package:workdey_frontend/features/location/widgets/gps_location_button.dart';
import 'package:workdey_frontend/features/location/widgets/zone_selector.dart';

class LocationSetupScreen extends ConsumerStatefulWidget {
  final bool isFirstTime;
  
  const LocationSetupScreen({
    super.key,
    this.isFirstTime = false,
  });

  @override
  ConsumerState<LocationSetupScreen> createState() => _LocationSetupScreenState();
}

class _LocationSetupScreenState extends ConsumerState<LocationSetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  LocationZone? _selectedHomeZone;
  Position? _gpsPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isFirstTime ? 'Setup Location' : 'Update Location'),
        leading: widget.isFirstTime ? null : const BackButton(),
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentPage + 1) / 3,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
          
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildWelcomePage(),
                _buildGPSPage(),
                _buildZoneSelectionPage(),
              ],
            ),
          ),
          
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousPage,
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentPage > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canProceed() ? _nextPage : null,
                    child: Text(_currentPage == 2 ? 'Finish' : 'Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 120,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 32),
          Text(
            'Find Jobs Near You',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Set up your location to discover relevant job opportunities in your area and get transport cost estimates.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildFeatureList(),
        ],
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      ('🎯', 'Find jobs within your travel range'),
      ('💰', 'See transport costs before applying'),
      ('📍', 'Get precise distance calculations'),
      ('🔔', 'Receive alerts for nearby opportunities'),
    ];

    return Column(
      children: features
          .map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      feature.$1,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        feature.$2,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildGPSPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.gps_fixed,
            size: 100,
            color: _gpsPosition != null ? Colors.green : Colors.grey,
          ),
          const SizedBox(height: 32),
          Text(
            'Enable GPS Location',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Allow GPS access for the most accurate job matching and distance calculations.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          GPSLocationButton(
            onLocationObtained: (position) {
              setState(() {
                _gpsPosition = position;
              });
            },
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => setState(() => _gpsPosition = Position(
              latitude: 0, longitude: 0, timestamp: DateTime.now(),
              accuracy: 0, altitude: 0, altitudeAccuracy: 0, heading: 0,
              headingAccuracy: 0, speed: 0, speedAccuracy: 0,
            )), // Dummy position to skip
            child: const Text('Skip GPS (less accurate results)'),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneSelectionPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Your Home Area',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the area where you live. This helps us find jobs within your travel range.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ZoneSelector(
            label: 'Home Area',
            hint: 'Search for your neighborhood...',
            onZoneSelected: (zone) {
              setState(() {
                _selectedHomeZone = zone;
              });
            },
          ),
          const SizedBox(height: 24),
          if (_selectedHomeZone != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Selected Area',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedHomeZone!.fullName ?? '${_selectedHomeZone!.name}, ${_selectedHomeZone!.city}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (_selectedHomeZone!.description?.isNotEmpty == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _selectedHomeZone!.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return true; // Welcome page
      case 1:
        return _gpsPosition != null; // GPS page
      case 2:
        return _selectedHomeZone != null; // Zone selection
      default:
        return false;
    }
  }

  void _nextPage() {
    if (_currentPage == 2) {
      _finishSetup();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finishSetup() async {
    try {
      // Update user location preferences
      await ref.read(locationPreferencesProvider.notifier).updateHomeZone(_selectedHomeZone!);
      
      if (mounted) {
        // Show success and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location setup completed!'),
            backgroundColor: Colors.green,
          ),
        );
        
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving location: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}