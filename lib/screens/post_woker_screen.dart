import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/providers/post_worker_provider.dart';
import 'package:workdey_frontend/features/workers/myworkerscard_detailes_screen.dart';
import 'package:workdey_frontend/features/workers/wokers_card.dart';
import 'package:workdey_frontend/screens/postworker_form.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';

class PostedWorkersScreen extends ConsumerStatefulWidget {
  const PostedWorkersScreen({super.key});

  @override
  ConsumerState<PostedWorkersScreen> createState() => _PostedWorkersScreenState();
}

class _PostedWorkersScreenState extends ConsumerState<PostedWorkersScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial jobs when screen first loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(myWorkersProvider) is! AsyncData) {
      ref.read(myWorkersProvider.notifier).loadWorkers();
    }
  });
  }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    
    if (maxScroll - currentScroll <= delta) {
      final notifier = ref.read(myWorkersProvider.notifier);
      if (notifier.hasMore) {
        notifier.loadNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final workersState = ref.watch(myWorkersProvider);
    
    return Scaffold(
      appBar: const CustomAppBar.withoutSearch(
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(myWorkersProvider.notifier).refreshWorker(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                 // const JobSectionSelector(),
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
            workersState.when(
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

                final hasMore = ref.read(myWorkersProvider.notifier).hasMore;
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
                      return WorkerCard(
            worker: paginated.results[index],
                        onTap: () => _viewWorkersDetails(paginated.results[index]),
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
        onPressed: _navigateToPostworkerForm,
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
      await ref.read(myWorkersProvider.notifier).refreshWorker();
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
            'You have no Workers Card yet',
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
              'All your Work Profiles will appear here. Click the + button to add a Card',
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

  void _navigateToPostworkerForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostWorkerForm()),
    ).then((_) {
      // Refresh jobs when returning from posting a new job
      ref.read(myWorkersProvider.notifier).refreshWorker();
    });
  }

  void _viewWorkersDetails(Worker worker) {
     Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WorkerDetailsScreen(worker: worker),
    ),
  );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}