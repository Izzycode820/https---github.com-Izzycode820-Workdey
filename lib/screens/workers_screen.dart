// screens/workers_screen.dart - REDESIGNED TO MATCH FIND JOB HOME SCREEN
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workdey_frontend/core/providers/get_workers_provider.dart';
import 'package:workdey_frontend/core/providers/saved_worker_provider.dart';
import 'package:workdey_frontend/core/providers/location/gps_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/workers/get_workers_card.dart';
import 'package:workdey_frontend/features/workers/wokers_card.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class WorkersScreen extends ConsumerStatefulWidget {
  const WorkersScreen({super.key});

  @override
  ConsumerState<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends ConsumerState<WorkersScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  
  // Worker listing modes
  WorkerListingMode _currentMode = WorkerListingMode.allWorkers; // Start with all workers
  bool _isLocationLoading = false;
  bool _hasLocationPermission = false;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_scrollListener);
    
    // Initialize location and workers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
      // Load initial workers
      _loadWorkersByMode(WorkerListingMode.allWorkers);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
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

  Future<void> _loadWorkersByMode(WorkerListingMode mode) async {
    switch (mode) {
      case WorkerListingMode.nearbyGPS:
        // TODO: Implement GPS-based worker search in future
        // This will use location-based worker filtering
        break;
        
      case WorkerListingMode.allWorkers:
        // ✅ Use regular worker provider
        await ref.read(workersNotifierProvider.notifier).loadInitialWorkers(forceRefresh: true);
        break;
    }
  }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    
    if (maxScroll - currentScroll <= delta) {
      // Only paginate for all workers
      if (_currentMode == WorkerListingMode.allWorkers) {
        final notifier = ref.read(workersNotifierProvider.notifier);
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
        searchType: SearchType.worker,
        showSearchBar: true,
        actionButton: _buildPostWorkerButton(),
      ),
      body: Column(
        children: [
          // Enhanced Location Status Bar (matching job screen)
          _buildLocationStatusBar(gpsState),
          
          // Worker Mode Tabs (2 tabs only)
          _buildWorkerModeTabs(),
          
          // Worker Listing Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 🎯 Near You Tab - Coming Soon
                _buildNearbyWorkersTab(),
                
                // 🎯 All Workers Tab - Use regular provider
                _buildAllWorkersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStatusBar(EnhancedGPSLocationState gpsState) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            _hasLocationPermission ? Icons.gps_fixed : Icons.gps_off,
            size: 16,
            color: _hasLocationPermission ? Colors.green[600] : Colors.orange[600],
          ),
          const SizedBox(width: 6),
          Text(
            _hasLocationPermission ? 'GPS Active' : 'GPS Disabled',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _hasLocationPermission ? Colors.green[700] : Colors.orange[700],
            ),
          ),
          if (!_hasLocationPermission && !_isLocationLoading) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _initializeLocation,
              child: Text(
                'Enable',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          if (_isLocationLoading) ...[
            const SizedBox(width: 8),
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWorkerModeTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        onTap: (index) => _onTabChanged(index),
        tabs: [
          _buildTab(Icons.my_location, 'Near You', _hasLocationPermission),
          _buildTab(Icons.people, 'All Workers', true),
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
      WorkerListingMode.nearbyGPS,
      WorkerListingMode.allWorkers,
    ];

    final newMode = modes[index];
    
    // Prevent switching to GPS mode without permission (but allow for coming soon display)
    if (newMode == WorkerListingMode.nearbyGPS && !_hasLocationPermission) {
      // Don't prevent switching, just show the coming soon message
    }

    setState(() => _currentMode = newMode);
    
    if (newMode == WorkerListingMode.allWorkers) {
      _loadWorkersByMode(newMode);
    }
  }

  // 🎯 Near You Tab - Coming Soon
  Widget _buildNearbyWorkersTab() {
    return RefreshIndicator(
      onRefresh: () async => _initializeLocation(),
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildComingSoonHeader(),
          ),
          
          // Coming Soon Content
          SliverFillRemaining(
            child: _buildComingSoonState(),
          ),
        ],
      ),
    );
  }

  // 🎯 All Workers Tab - Regular functionality
  Widget _buildAllWorkersTab() {
    final workersState = ref.watch(workersNotifierProvider);

    return RefreshIndicator(
      onRefresh: () => _loadWorkersByMode(WorkerListingMode.allWorkers),
      child: CustomScrollView(
        controller: _scrollController, // Enable scrolling for pagination
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: workersState.when(
              data: (paginated) => _buildAllWorkersHeader(paginated.count),
              loading: () => _buildLoadingHeader(),
              error: (_, __) => _buildErrorHeader(),
            ),
          ),
          
          // Workers List
          workersState.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: _buildErrorState(e.toString(), () => _loadWorkersByMode(WorkerListingMode.allWorkers)),
            ),
            data: (paginated) {
              if (paginated.results.isEmpty) {
                return SliverFillRemaining(
                  child: _buildEmptyState(),
                );
              }

              final hasMore = ref.read(workersNotifierProvider.notifier).hasMore;

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
                    
                    // 📍 WORKER CARD CALLED HERE - This is where WorkerCard is being used
                    return GetWorkerCard(
                      worker: paginated.results[index],
                      onBookmarkPressed: (workerId) {
                        final isCurrentlySaved = paginated.results[index].isSaved;
                        ref.read(savedWorkersProvider.notifier)
                            .toggleSave(workerId, isCurrentlySaved);
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

  // Header builders (matching job screen style)
  Widget _buildComingSoonHeader() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.orange[50],
        border: Border(
          bottom: BorderSide(color: Colors.orange[200]!, width: 0.5),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.construction,
              size: 14,
              color: Colors.orange[700],
            ),
            const SizedBox(width: 8),
            Text(
              'Location-based worker search coming soon',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.orange[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllWorkersHeader(int count) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border(
          bottom: BorderSide(color: Colors.blue[200]!, width: 0.5),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          '$count skilled workers available',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.blue[700],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingHeader() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            Text(
              'Loading workers...',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorHeader() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border(
          bottom: BorderSide(color: Colors.red[200]!, width: 0.5),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.error,
              size: 14,
              color: Colors.red[700],
            ),
            const SizedBox(width: 8),
            Text(
              'Error loading workers',
              style: TextStyle(
                fontSize: 13,
                color: Colors.red[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // State builders
  Widget _buildComingSoonState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.orange[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.construction,
              size: 48,
              color: Colors.orange[600],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Feature Coming Soon',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'re working on location-based worker search.\nFor now, explore all available workers in the next tab.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _tabController.animateTo(1), // Switch to All Workers tab
            icon: const Icon(Icons.people, size: 18),
            label: const Text('View All Workers'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E8728),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline,
              size: 48,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Workers Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No skilled workers are currently available.\nTry adjusting your search or check back later.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _loadWorkersByMode(WorkerListingMode.allWorkers),
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E8728),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
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
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E8728),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostWorkerButton() {
    return TextButton(
      onPressed: () async {
        await Navigator.pushNamed(context, AppRoutes.postWorker);
      },
      child: const Text(
        'Post Profile',
        style: TextStyle(color: Color(0xFF3E8728)),
      ),
    );
  }
}

enum WorkerListingMode {
  nearbyGPS,
  allWorkers,
}