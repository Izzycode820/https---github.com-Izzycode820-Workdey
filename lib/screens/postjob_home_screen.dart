import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/features/jobs/posted_job_details.dart';
import 'package:workdey_frontend/features/jobs/posted_job_widget.dart';
import 'package:workdey_frontend/screens/postjob_form.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';
import 'package:workdey_frontend/shared/components/job_section.dart';

class PostedJobsScreen extends ConsumerStatefulWidget {
  const PostedJobsScreen({super.key});

  @override
  ConsumerState<PostedJobsScreen> createState() => _PostedJobsScreenState();
}

class _PostedJobsScreenState extends ConsumerState<PostedJobsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial jobs when screen first loads
    Future.microtask(() => ref.read(postedJobsProvider.notifier).loadInitialJobs());
  }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    
    if (maxScroll - currentScroll <= delta) {
      final notifier = ref.read(postedJobsProvider.notifier);
      if (notifier.hasMore) {
        notifier.loadNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobsState = ref.watch(postedJobsProvider);
    
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postedJobsProvider.notifier).refreshJobs(),
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
                    child: _buildEmptyState(),
                  );
                }

                final hasMore = ref.read(postedJobsProvider.notifier).hasMore;
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
                      return PostedJobItem(
                        job: paginated.results[index],
                        onTap: () => _viewJobDetails(paginated.results[index]),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToPostJobForm,
        backgroundColor: const Color(0xFF3E8728),
        child: const Icon(Icons.add, color: Colors.white),
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
      await ref.read(postedJobsProvider.notifier).refreshJobs();
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
            'No jobs Posted yet',
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
              'All your posted jobs will appear here. Click the + button to post a job',
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

  void _navigateToPostJobForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostJobForm()),
    ).then((_) {
      // Refresh jobs when returning from posting a new job
      ref.read(postedJobsProvider.notifier).refreshJobs();
    });
  }

  void _viewJobDetails(Job job) {
     Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PostedJobDetails(job: job),
    ),
  );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}