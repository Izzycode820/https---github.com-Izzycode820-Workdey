import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/get_job_provider.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/providers/route_state_provider.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/jobs/job_card.dart';
import 'package:workdey_frontend/features/search_filter/job/searchwidgets/job_search_bar.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

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
    final searchNotifier = ref.read(jobSearchProvider.notifier);
    if (searchNotifier.state.query.isNotEmpty || searchNotifier.state.hasActiveFilters) {
      searchNotifier.loadMore();
    } else {
      final notifier = ref.read(jobsNotifierProvider.notifier);
      if (notifier.hasMore) {
        notifier.loadNextPage();
      }
    }
  }
}


@override
Widget build(context) {
  final jobsState = ref.watch(jobsNotifierProvider);
  final searchState = ref.watch(jobSearchProvider);
    final hasActiveSearch = searchState.query.isNotEmpty || searchState.hasActiveFilters;

  return Scaffold(
    appBar: CustomAppBar(
      actionButton: TextButton(
    onPressed: () => Navigator.pushNamed(context, AppRoutes.postJobs),
    child: const Text(
      'Post Job',
      style: TextStyle(color: Color(0xFF3E8728)),
    ),
  ),
    ),
    body: RefreshIndicator(
      onRefresh: () async {
          setState(() => _isRefreshing = true);
          try {
          await ref.read(jobSearchProvider.notifier).refreshSearch();
        } finally {
          if (mounted) setState(() => _isRefreshing = false);
        }
      },

      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
              //  const JobSectionSelector(),
          
          // Search Bar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: JobSearchBar(),
          ),
          if (hasActiveSearch) 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            'Search results for "${searchState.query}"',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => ref.read(jobSearchProvider.notifier).reset(),
                            child: const Text('Clear search'),
                          ),
                        ],
                      ),
                    ),
          _buildRefreshButton(),
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
                        Text(
                            hasActiveSearch 
                              ? 'No jobs found for "${searchState.query}"'
                              : 'No jobs available',
                          ),
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