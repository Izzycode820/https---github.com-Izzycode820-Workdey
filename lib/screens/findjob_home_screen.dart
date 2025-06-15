import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/get_job_provider.dart';
import 'package:workdey_frontend/core/providers/route_state_provider.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/features/jobs/job_card.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/screens/postjob_home_screen.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';
import 'package:workdey_frontend/shared/components/job_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isFindJobsSelected = true;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial jobs
    // Initialize with correct selector state
    Future.microtask(() {
      ref.read(appSectionProvider.notifier).state = AppSection.findJobs;
      if (ref.read(jobsNotifierProvider) is! AsyncData) {
        ref.read(jobsNotifierProvider.notifier).loadInitialJobs();
        ref.read(lastRefreshTimeProvider.notifier).state = DateTime.now();
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

// Add this method to handle route changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/post-jobs') {
      ref.read(appSectionProvider.notifier).state = AppSection.postJobs;
    } else {
      ref.read(appSectionProvider.notifier).state = AppSection.findJobs;
    }
  }

  @override
Widget build(BuildContext context) {
  final jobsState = ref.watch(jobsNotifierProvider);
  final currentSection = ref.watch(appSectionProvider);

  return Scaffold(
    appBar: const CustomAppBar(),
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
                const JobSectionSelector(),
          
          // Search Bar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchBarWidget(),
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