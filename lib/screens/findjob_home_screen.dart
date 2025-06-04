import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/get_job_provider.dart';
import 'package:workdey_frontend/features/jobs/job_card.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/screens/postjob_home_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isFindJobsSelected = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial jobs
    Future.microtask(() => 
      ref.read(jobsNotifierProvider.notifier).loadInitialJobs());
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
      appBar: AppBar(
        title: const Text(
          'Work dey',
          style: TextStyle(
            color: Color(0xFF3E8728),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(jobsNotifierProvider.notifier).refreshJobs(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
          // Job Type Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5E7D5E).withOpacity(0.31),
                    blurRadius: 25,
                    offset: const Offset(0, 4),
              )],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!_isFindJobsSelected) {
                        setState(() => _isFindJobsSelected = true);
                      }},
                      child: Center(
                        child: Text(
                          'Find Jobs',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: _isFindJobsSelected 
                              ? const Color(0xFF07864B) 
                              : const Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 19,
                    color: const Color(0xFF1E1E1E),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_isFindJobsSelected) {
                        setState(() => _isFindJobsSelected = false);
                     setState(() => _isFindJobsSelected = false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostedJobsScreen(),
                  ),
                );
              }
            },
                      child: Center(
                        child: Text(
                          'Post Job',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: !_isFindJobsSelected 
                              ? const Color(0xFF07864B) 
                              : const Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Search Bar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchBarWidget(),
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
                child: Center(child: Text('Error: ${e.toString()}')),
              ),
              data: (paginated) {
                final hasMore = ref.read(jobsNotifierProvider.notifier).hasMore;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {

                      if (index >= paginated.results.length) {
                        return hasMore 
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: SizedBox(
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
                          ref.read(jobsNotifierProvider.notifier).toggleSave(jobId);
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}