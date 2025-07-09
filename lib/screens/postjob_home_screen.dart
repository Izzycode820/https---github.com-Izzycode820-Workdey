import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/features/jobs/postjob/posted_job_widget.dart';
import 'package:workdey_frontend/screens/postjob_form.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';

class UpdatedPostedJobsScreen extends ConsumerStatefulWidget {
  const UpdatedPostedJobsScreen({super.key});

  @override
  ConsumerState<UpdatedPostedJobsScreen> createState() => _UpdatedPostedJobsScreenState();
}

class _UpdatedPostedJobsScreenState extends ConsumerState<UpdatedPostedJobsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial jobs when screen first loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(postedJobsProvider) is! AsyncData) {
        ref.read(postedJobsProvider.notifier).loadInitialJobs();
      }
    });
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
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar.withoutSearch(),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postedJobsProvider.notifier).refreshJobs(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Header with stats
            SliverToBoxAdapter(
              child: _buildHeader(jobsState),
            ),
            
            // Jobs list
            jobsState.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: _buildErrorState(e.toString()),
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
                      
                      return CleanPostedJobCard(
                        job: paginated.results[index],
                        onEdit: () => _navigateToEditJob(paginated.results[index]),
                        onDelete: () => _deleteJob(paginated.results[index].id),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToPostJobForm,
        backgroundColor: const Color(0xFF3E8728),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'Post Job',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildHeader(AsyncValue jobsState) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'My Posted Jobs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => ref.read(postedJobsProvider.notifier).refreshJobs(),
                icon: const Icon(Icons.refresh, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          jobsState.when(
            data: (paginated) => Text(
              '${paginated.count} ${paginated.count == 1 ? 'job' : 'jobs'} posted',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            loading: () => Text(
              'Loading jobs...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            error: (_, __) => Text(
              'Error loading jobs',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
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
                Icons.work_outline,
                size: 48,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Jobs Posted Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start posting jobs to find the perfect candidates for your open positions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _navigateToPostJobForm,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Post Your First Job'),
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
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.read(postedJobsProvider.notifier).refreshJobs(),
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
      ),
    );
  }

  void _navigateToPostJobForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CleanJobForm(), // Clean form for creating
      ),
    ).then((_) {
      // Refresh jobs when returning
      ref.read(postedJobsProvider.notifier).refreshJobs();
    });
  }

  void _navigateToEditJob(Job job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CleanJobForm(existingJob: job), // Clean form for editing
      ),
    ).then((_) {
      // Refresh jobs when returning
      ref.read(postedJobsProvider.notifier).refreshJobs();
    });
  }

  Future<void> _deleteJob(int jobId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Job'),
        content: const Text(
          'Are you sure you want to delete this job posting? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(postedJobsProvider.notifier).removeJob(jobId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Job deleted successfully'),
              backgroundColor: Color(0xFF3E8728),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete job: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}