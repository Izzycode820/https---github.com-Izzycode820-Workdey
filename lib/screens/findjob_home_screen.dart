// enhanced_findjob_home_screen.dart - FIXED VERSION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/providers/location/gps_provider.dart';
import 'package:workdey_frontend/core/providers/get_job_provider.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/jobs/getjobs/job_card.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class EnhancedHomeScreen extends ConsumerStatefulWidget {
  const EnhancedHomeScreen({super.key});

  @override
  ConsumerState<EnhancedHomeScreen> createState() => _EnhancedHomeScreenState();
}

class _EnhancedHomeScreenState extends ConsumerState<EnhancedHomeScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  
  // Job listing modes
  JobListingMode _currentMode = JobListingMode.general; // Start with general jobs
  bool _isLocationLoading = false;
  bool _hasLocationPermission = false;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_scrollListener);
    
    // Initialize location and jobs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
      // Load initial general jobs
      _loadJobsByMode(JobListingMode.general);
    });
  }

  Future<void> _initializeLocation() async {
    setState(() => _isLocationLoading = true);
    
    try {
      // Check and request GPS permission
      await ref.read(enhancedGpsLocationProvider.notifier).requestLocationAndUpdate();
      final gpsState = ref.read(enhancedGpsLocationProvider);
      
      if (gpsState.currentPosition != null) {
        setState(() {
          _hasLocationPermission = true;
          _currentPosition = gpsState.currentPosition;
        });
      } else {
        setState(() {
          _hasLocationPermission = false;
        });
      }
    } catch (e) {
      debugPrint('Location initialization error: $e');
      setState(() {
        _hasLocationPermission = false;
      });
    } finally {
      setState(() => _isLocationLoading = false);
    }
  }

  // 🎯 FIXED: Use correct providers for each mode
  Future<void> _loadJobsByMode(JobListingMode mode) async {
    switch (mode) {
      case JobListingMode.nearbyGPS:
        // ✅ Use GPS provider (will trigger nearbyJobsProvider)
        // Just invalidate to refresh the provider
        ref.invalidate(nearbyJobsProvider(15.0));
        break;
        
      case JobListingMode.smartNearby:
        // ✅ Use GPS provider (will trigger smartNearbyJobsProvider)
        ref.invalidate(smartNearbyJobsProvider);
        break;
        
      case JobListingMode.general:
        // ✅ Use regular job provider
        await ref.read(jobsNotifierProvider.notifier).loadInitialJobs(forceRefresh: true);
        break;
        
      case JobListingMode.location:
        // This will be handled by location search
        break;
    }
  }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    
    if (maxScroll - currentScroll <= delta) {
      // Only paginate for general jobs
      if (_currentMode == JobListingMode.general) {
        final notifier = ref.read(jobsNotifierProvider.notifier);
        if (notifier.hasMore) {
          notifier.loadNextPage();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gpsState = ref.watch(enhancedGpsLocationProvider);

    return Scaffold(
      appBar: CustomAppBar(
        searchType: SearchType.job,
        showSearchBar: true,
        actionButton: _buildPostJobButton(),
      ),
      body: Column(
        children: [
          // Enhanced Location Status Bar
          _buildLocationStatusBar(gpsState),
          
          // Job Mode Tabs
          _buildJobModeTabs(),
          
          // Job Listing Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 🎯 Near You Tab - Use GPS provider
                _buildGPSJobsList(JobListingMode.nearbyGPS),
                
                // 🎯 Smart Tab - Use GPS provider  
                _buildGPSJobsList(JobListingMode.smartNearby),
                
                // 🎯 All Jobs Tab - Use regular provider
                _buildRegularJobsList(),
                
                // Search Tab
                _buildLocationSearchTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 NEW: Build GPS-based jobs list
  Widget _buildGPSJobsList(JobListingMode mode) {
    // Choose the correct GPS provider
    AsyncValue<List<Job>> gpsJobsState;
    
    if (mode == JobListingMode.nearbyGPS) {
      gpsJobsState = ref.watch(nearbyJobsProvider(15.0));
    } else {
      gpsJobsState = ref.watch(smartNearbyJobsProvider);
    }

    return RefreshIndicator(
      onRefresh: () async => _loadJobsByMode(mode),
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: gpsJobsState.when(
              data: (jobs) => _buildGPSJobsHeader(mode, jobs.length),
              loading: () => _buildLoadingHeader(mode),
              error: (_, __) => _buildErrorHeader(mode),
            ),
          ),
          
          // Jobs List
          gpsJobsState.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: _buildErrorState(e.toString(), () => _loadJobsByMode(mode)),
            ),
            data: (jobs) {
              if (jobs.isEmpty) {
                return SliverFillRemaining(
                  child: _buildEmptyState(mode),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => JobCard(
                    job: jobs[index],
                    onBookmarkPressed: (jobId) {
                      // Handle bookmark
                    },
                  ),
                  childCount: jobs.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // 🎯 Build regular jobs list (All Jobs tab)
  Widget _buildRegularJobsList() {
    final jobsState = ref.watch(jobsNotifierProvider);

    return RefreshIndicator(
      onRefresh: () => _loadJobsByMode(JobListingMode.general),
      child: CustomScrollView(
        controller: _scrollController, // Enable scrolling for pagination
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: jobsState.when(
              data: (paginated) => _buildRegularJobsHeader(paginated.count),
              loading: () => _buildLoadingHeader(JobListingMode.general),
              error: (_, __) => _buildErrorHeader(JobListingMode.general),
            ),
          ),
          
          // Jobs List
          jobsState.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: _buildErrorState(e.toString(), () => _loadJobsByMode(JobListingMode.general)),
            ),
            data: (paginated) {
              if (paginated.results.isEmpty) {
                return SliverFillRemaining(
                  child: _buildEmptyState(JobListingMode.general),
                );
              }

              final hasMore = ref.read(jobsNotifierProvider.notifier).hasMore;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= paginated.results.length) {
                      return hasMore 
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox.shrink();
                    }
                    
                    return JobCard(
                      job: paginated.results[index],
                      onBookmarkPressed: (jobId) {
                        // Handle bookmark
                      },
                    );
                  },
                  childCount: paginated.results.length + (hasMore ? 1 : 0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStatusBar(EnhancedGPSLocationState gpsState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _hasLocationPermission ? Colors.green[50]! : Colors.orange[50]!,
            _hasLocationPermission ? Colors.green[100]! : Colors.orange[100]!,
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: _hasLocationPermission ? Colors.green[200]! : Colors.orange[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _hasLocationPermission ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _hasLocationPermission ? Icons.gps_fixed : Icons.gps_off,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getLocationStatusTitle(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: _hasLocationPermission ? Colors.green[800] : Colors.orange[800],
                  ),
                ),
                Text(
                  _getLocationStatusSubtitle(gpsState),
                  style: TextStyle(
                    fontSize: 12,
                    color: _hasLocationPermission ? Colors.green[600] : Colors.orange[600],
                  ),
                ),
              ],
            ),
          ),
          if (!_hasLocationPermission && !_isLocationLoading)
            TextButton(
              onPressed: _initializeLocation,
              child: Text(
                'Enable GPS',
                style: TextStyle(
                  color: Colors.orange[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          if (_isLocationLoading)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
        ],
      ),
    );
  }

  String _getLocationStatusTitle() {
    if (_isLocationLoading) return 'Getting your location...';
    if (_hasLocationPermission) return 'GPS Active';
    return 'GPS Disabled';
  }

  String _getLocationStatusSubtitle(EnhancedGPSLocationState gpsState) {
    if (_isLocationLoading) return 'Please wait while we find nearby jobs';
    if (_hasLocationPermission && gpsState.currentPosition != null) {
      final accuracy = gpsState.currentPosition!.accuracy;
      return 'Accuracy: ${accuracy.toStringAsFixed(0)}m • Finding jobs within 15km';
    }
    return 'Enable GPS to find jobs near you automatically';
  }

  Widget _buildJobModeTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        onTap: (index) => _onTabChanged(index),
        tabs: [
          _buildTab(Icons.my_location, 'Near You', _hasLocationPermission),
          _buildTab(Icons.psychology, 'Smart', _hasLocationPermission),
          _buildTab(Icons.work, 'All Jobs', true),
          _buildTab(Icons.search, 'Search', true),
        ],
        labelColor: const Color(0xFF3E8728),
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: const Color(0xFF3E8728),
        indicatorWeight: 3,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Tab _buildTab(IconData icon, String label, bool enabled) {
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: enabled ? null : Colors.grey[400],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: enabled ? null : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  void _onTabChanged(int index) {
    final modes = [
      JobListingMode.nearbyGPS,
      JobListingMode.smartNearby,
      JobListingMode.general,
      JobListingMode.location,
    ];

    final newMode = modes[index];
    
    // Prevent switching to GPS modes without permission
    if ((newMode == JobListingMode.nearbyGPS || newMode == JobListingMode.smartNearby) 
        && !_hasLocationPermission) {
      _showLocationPermissionDialog();
      _tabController.animateTo(_tabController.previousIndex);
      return;
    }

    setState(() => _currentMode = newMode);
    
    if (newMode != JobListingMode.location) {
      _loadJobsByMode(newMode);
    }
  }

  Widget _buildLocationSearchTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Location Search',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Search for jobs in any city or district',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 24),
          // Add your location search widget here
        ],
      ),
    );
  }

  // Helper methods
  Widget _buildGPSJobsHeader(JobListingMode mode, int count) {
    String title = mode == JobListingMode.nearbyGPS 
        ? '$count jobs within 15km'
        : '$count smart matches found';
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(title),
    );
  }

  Widget _buildRegularJobsHeader(int count) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text('$count jobs available'),
    );
  }

  Widget _buildLoadingHeader(JobListingMode mode) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text('Loading jobs...'),
        ],
      ),
    );
  }

  Widget _buildErrorHeader(JobListingMode mode) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.error, color: Colors.red),
          SizedBox(width: 16),
          Text('Error loading jobs'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text('Error: $error'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(JobListingMode mode) {
    String title;
    String subtitle;
    IconData icon;

    switch (mode) {
      case JobListingMode.nearbyGPS:
        title = 'No nearby jobs';
        subtitle = 'Try increasing your search radius or check back later';
        icon = Icons.location_off;
        break;
      case JobListingMode.smartNearby:
        title = 'No matches found';
        subtitle = 'Update your profile or preferences for better matches';
        icon = Icons.psychology_outlined;
        break;
      default:
        title = 'No jobs available';
        subtitle = 'Check back later for new opportunities';
        icon = Icons.work_off;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This feature requires location access to find jobs near you. '
          'Would you like to enable GPS location?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _initializeLocation();
            },
            child: const Text('Enable GPS'),
          ),
        ],
      ),
    );
  }

  Widget _buildPostJobButton() {
    return TextButton(
      onPressed: () async {
        await Navigator.pushNamed(context, AppRoutes.postJobs);
      },
      child: const Text(
        'Post Job',
        style: TextStyle(color: Color(0xFF3E8728)),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}

enum JobListingMode {
  nearbyGPS,
  smartNearby,
  general,
  location,
}