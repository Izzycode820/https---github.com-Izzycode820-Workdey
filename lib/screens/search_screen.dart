import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  final SearchType searchType;
  final String searchQuery;
  
  const SearchResultsScreen({
    super.key,
    required this.searchType,
    required this.searchQuery,
  });

  @override
  ConsumerState<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.text = widget.searchQuery;
    
    
    // Schedule the search after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerInitialSearch();
    });
  }


  void _triggerInitialSearch() {
    if (widget.searchType == SearchType.job) {
      ref.read(jobSearchNotifierProvider.notifier)
        ..setQuery(widget.searchQuery)
        ..searchJobs();
    } else {
      ref.read(workerSearchNotifierProvider.notifier)
        ..setQuery(widget.searchQuery)
        ..searchWorkers();
    }
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
      if (widget.searchType == SearchType.job) {
        ref.read(jobSearchNotifierProvider.notifier).searchJobs(loadMore: true);
      } else {
        ref.read(workerSearchNotifierProvider.notifier).searchWorkers(loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchType == SearchType.job 
            ? 'Job Results' 
            : 'Worker Results'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              searchType: widget.searchType,
              isStatic: false,
              isInputScreen: false,
            ),
          ),
          FilterChipsRow(searchType: widget.searchType),
          Expanded(
            child: widget.searchType == SearchType.job
                ? _buildJobResults(ref)
                : _buildWorkerResults(ref),
          ),
        ],
      ),
    );
  }

  Widget _buildJobResults(WidgetRef ref) {
    final state = ref.watch(jobSearchNotifierProvider);
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
        title: Text(job.title ?? 'No title'),
        subtitle: Text(job.location ?? 'No location'),
      ),
    );
  }

  Widget _buildWorkerResults(WidgetRef ref) {
    final state = ref.watch(workerSearchNotifierProvider);
    if (state.isLoading && state.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null) {
      return Center(child: Text('Error: ${state.error}'));
    }
    if (state.results.isEmpty) {
      return const Center(child: Text('No workers found'));
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
        return _buildWorkerItem(state.results[index]);
      },
    );
  }

  Widget _buildWorkerItem(Worker worker) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: worker.profilePicture != null 
              ? NetworkImage(worker.profilePicture!) 
              : null,
        ),
        title: Text(worker.userName ?? 'No name'),
        subtitle: Text(worker.skills?.join(', ') ?? 'No skills listed'),
      ),
    );
  }
}

class FilterChipsRow extends ConsumerWidget {
  final SearchType searchType;
  
  const FilterChipsRow({
    super.key,
    required this.searchType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (searchType == SearchType.job) ...[
            _buildJobFilterChip('Full-time', ref),
            _buildJobFilterChip('Remote', ref),
          ] else ...[
            _buildWorkerFilterChip('Available Now', ref),
            _buildWorkerFilterChip('Verified', ref),
          ],
        ],
      ),
    );
  }

  Widget _buildJobFilterChip(String label, WidgetRef ref) {
    return FilterChip(
      label: Text(label),
      onSelected: (selected) {
        ref.read(jobSearchNotifierProvider.notifier).searchJobs();
      },
    );
  }

  Widget _buildWorkerFilterChip(String label, WidgetRef ref) {
    return FilterChip(
      label: Text(label),
      onSelected: (selected) {
        ref.read(workerSearchNotifierProvider.notifier).searchWorkers();
      },
    );
  }
}