import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/providers/get_job_provider.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/core/providers/route_state_provider.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/jobs/job_by_location.dart';
import 'package:workdey_frontend/features/jobs/job_by_location_button.dart';
import 'package:workdey_frontend/features/jobs/job_card.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;
  bool _isNavigating = false;

 @override
void initState() {
  super.initState();
  _scrollController.addListener(_scrollListener);
  
  // Load jobs if not already loaded
 WidgetsBinding.instance.addPostFrameCallback((_) {
    if (ref.read(jobsNotifierProvider) is! AsyncData) {
      ref.read(jobsNotifierProvider.notifier).loadInitialJobs();
    }
  });
}

  void _scrollListener() {
  final double maxScroll = _scrollController.position.maxScrollExtent;
  final double currentScroll = _scrollController.position.pixels;
  final double delta = MediaQuery.of(context).size.height * 0.20;
  
  if (maxScroll - currentScroll <= delta) {
    final notifier = ref.read(jobsNotifierProvider.notifier);
    if (notifier.hasMore ) {
      notifier.loadNextPage();
    }
  }
}


  @override
Widget build(BuildContext context) {
  final jobsState = ref.watch(jobsNotifierProvider);

  return Scaffold(
    appBar: CustomAppBar(
     searchType: SearchType.job,
        showSearchBar: true,
      actionButton: Builder(
  builder: (context) => TextButton(
    onPressed: _isNavigating ? null : () async {
  setState(() => _isNavigating = true);
  try {
    // Initialize provider in a post-frame callback
    await Future.microtask(() {
      ref.read(postJobNotifierProvider.notifier);
    });
    await Navigator.pushNamed(context, AppRoutes.postJobs);
  } finally {
    if (mounted) setState(() => _isNavigating = false);
  }
},
    // {
    //   setState(() => _isNavigating = true);
    //   await Future.microtask(() {});
    //   try {
    //     await Navigator.pushNamed(context, AppRoutes.postJobs);
    //   } finally {
    //     if (mounted) setState(() => _isNavigating = false);
    //   }
    // },
    child: _isNavigating
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text(
            'Post Job',
            style: TextStyle(color: Color(0xFF3E8728)),
          ),
  ),
),
    ),
    body: RefreshIndicator(
      onRefresh: () async {
          await ref.read(jobsNotifierProvider.notifier).refreshJobs();
          ref.read(lastRefreshTimeProvider.notifier).state = DateTime.now();
        },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            _buildRefreshButton(),
            const Spacer(),
            LocationSearchButton(
              onPressed: _showLocationSearchSheet,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: jobsState.when(
            data: (paginated) => _buildHeaderText(paginated),
            loading: () => const Text("Loading jobs..."),
            error: (_, __) => const Text("Error loading jobs"),
          ),
        ),
      ),
    ],
  ),
),
          
               // Jobs List
            jobsState.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${e.toString()}'),
                    _buildRefreshButton(),
                  ],
                ),
              ),
            ),
            data: (paginated) {
              if (paginated.results.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No jobs available'),
                       _buildRefreshButton(),
                      ],
                    ),
                  ),
                );
              }

              final hasMore = ref.read(jobsNotifierProvider.notifier).hasMore;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= paginated.results.length) {
                      return hasMore 
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                    }
                    return JobCard(
                      job: paginated.results[index],
                      onBookmarkPressed: (jobId) {
                        // Get the current saved status
                        final isCurrentlySaved = paginated.results[index].isSaved;
                        // Use the savedJobsProvider instead
                        ref.read(savedJobsProvider.notifier).toggleSave(jobId, isCurrentlySaved);
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
    ),
  );
}

Widget _buildHeaderText(PaginatedResponse<Job> paginated) {
  final notifier = ref.read(jobsNotifierProvider.notifier);
  final count = paginated.count;

  if (notifier.currentCity == null) {
    return Text('$count general jobs available');
  }

  if (notifier.currentDistrict == null) {
    return Text('$count jobs in ${notifier.currentCity}');
  }

  // Check if backend sent a fallback message
  if (paginated.results.isNotEmpty && paginated.results[0].fallbackMessage != null) {
    return Text(paginated.results[0].fallbackMessage!);
  }

  return Text('$count jobs in ${notifier.currentCity}, ${notifier.currentDistrict}');
}

void _showLocationSearchSheet() {
  showModalBottomSheet(
    context: context,
    builder: (context) => LocationSearchSheet(
      onSearch: (city, district) {
        ref.read(jobsNotifierProvider.notifier).searchByLocation(
          city: city,
          district: district,
        );
      },
    ),
  );
}

 Widget _buildRefreshButton() {
    return _isRefreshing
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        : IconButton(
            icon: const Icon(Icons.refresh, size: 24),
            onPressed: _handleRefresh,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          );
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    
    setState(() => _isRefreshing = true);
    try {
      await ref.read(jobsNotifierProvider.notifier).refreshJobs();
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }
  

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}