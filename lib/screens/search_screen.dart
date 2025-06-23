import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/job_search_provider.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';

class JobSearchPage extends ConsumerStatefulWidget {
  final String? searchQuery;
  
  const JobSearchPage({
    super.key,
    this.searchQuery,
  });

  @override
  ConsumerState<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends ConsumerState<JobSearchPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.searchQuery != null) {
      _searchController.text = widget.searchQuery!;
    }
    // Trigger initial search if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.searchQuery != null) {
        ref.read(jobSearchNotifierProvider.notifier)
          ..setQuery(widget.searchQuery!)
          ..searchJobs();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Replaced ActiveSearchBar with SearchBarWidget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              isJobSearch: true,
              isStatic: false,
              isInputScreen: false,
            ),
          ),
          const FilterChipsRow(),          
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

// Filter chips implementation
class FilterChipsRow extends ConsumerWidget {
  const FilterChipsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Full-time'),
            onSelected: (bool value) {
              // Implement filter logic
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Remote'),
            onSelected: (bool value) {
              // Implement filter logic
            },
          ),
          // Add more filter chips as needed
        ],
      ),
    );
  }
}