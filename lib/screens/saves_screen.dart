import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/features/jobs/job_card.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';
import 'package:workdey_frontend/shared/components/job_section.dart';

class SavedJobsPage extends ConsumerStatefulWidget {
  const SavedJobsPage({super.key});

  @override
  ConsumerState<SavedJobsPage> createState() => _SavedJobsPageState();
}

class _SavedJobsPageState extends ConsumerState<SavedJobsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial jobs when screen first loads
    Future.microtask(() => ref.read(savedJobsProvider.notifier).loadInitialJobs());
  }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    
    if (maxScroll - currentScroll <= delta) {
      final notifier = ref.read(savedJobsProvider.notifier);
      if (notifier.hasMore) {
        notifier.loadNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedJobsState = ref.watch(savedJobsProvider);
    
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () => ref.read(savedJobsProvider.notifier).refresh(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  JobSectionSelector(
                    isFindJobsSelected: false,
                    onFindJobsTap: () => Navigator.pop(context),
                    onPostJobTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildRefreshButton(),
                    ),
                  ),
                ],
              ),
            ),
            savedJobsState.when(
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
                    child: _buildEmptyState(),
                  );
                }

                final hasMore = ref.read(savedJobsProvider.notifier).hasMore;
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: JobCard(
                          job: paginated.results[index],
                          onBookmarkPressed: (jobId) {
                            // Get the current saved status
                            final isCurrentlySaved = 
                                paginated.results[index].isSaved;
                            // Toggle save status
                            ref.read(savedJobsProvider.notifier)
                              .toggleSave(jobId, isCurrentlySaved);
                          },
                        ),
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
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
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
      await ref.read(savedJobsProvider.notifier).refresh();
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_jobs.jpg',
            width: 160,
            height: 117,
          ),
          const SizedBox(height: 24),
          const Text(
            'No saved jobs yet',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Jobs you save will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}