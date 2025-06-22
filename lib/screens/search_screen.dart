// job_search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/job_search_provider.dart';
import 'package:workdey_frontend/core/providers/providers.dart';

class JobSearchPage extends ConsumerStatefulWidget {
  const JobSearchPage({super.key});

  @override
  ConsumerState<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends ConsumerState<JobSearchPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Trigger initial search if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(jobSearchNotifierProvider.notifier).searchJobs();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
      ref.read(jobSearchNotifierProvider.notifier).searchJobs(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobSearchNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Search Results'),
      ),
      body: Column(
        children: [
          // Search bar can be placed here if needed
          Expanded(
            child: _buildResultsList(state),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(JobSearchState state) {
    if (state.isLoading && state.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text('Error: ${state.error}'));
    }

    if (state.results.isEmpty) {
      return const Center(child: Text('No jobs found'));
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: state.hasMore 
          ? state.results.length + 1 
          : state.results.length,
      itemBuilder: (context, index) {
        if (index >= state.results.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildJobItem(state.results[index]);
      },
    );
  }

  Widget _buildJobItem(Job job) {
    return Card(
      child: ListTile(
        title: Text(job.title),
        subtitle: Text(job.location),
        // Add more job details as needed
      ),
    );
  }
}