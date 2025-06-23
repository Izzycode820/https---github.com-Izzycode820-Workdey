import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/features/search_filter/job/job_filter_chips.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/features/search_filter/worker/workers_filter_chips.dart';
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
  final maxScroll = _scrollController.position.maxScrollExtent;
  final currentScroll = _scrollController.position.pixels;
  const delta = 100.0;
  
  if (maxScroll - currentScroll <= delta) {
    _loadMoreResults();
  }
}

void _loadMoreResults() {
  if (widget.searchType == SearchType.job) {
    final state = ref.read(jobSearchNotifierProvider);
    if (!state.isLoading && state.hasMore) {
      ref.read(jobSearchNotifierProvider.notifier).searchJobs(
        query: widget.searchQuery,
        loadMore: true,
      );
    }
  } else {
    final state = ref.read(workerSearchNotifierProvider);
    if (!state.isLoading && state.hasMore) {
      ref.read(workerSearchNotifierProvider.notifier).searchWorkers(
        query: widget.searchQuery,
        loadMore: true,
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.searchType == SearchType.job 
        ? jobSearchNotifierProvider 
        : workerSearchNotifierProvider);
        
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchType == SearchType.job 
            ? 'Job Results' 
            : 'Worker Results'),
            actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showMainFilterSheet(context),
          ),
        ],
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
          const SizedBox(height: 8),
        // Make filter chips scrollable and properly constrained
        SizedBox(
          height: 50,
          child: widget.searchType == SearchType.job
              ? const JobFilterChips()
              : const WorkerFilterChips(),
          ),
        const SizedBox(height: 8),
        Expanded(
          child: widget.searchType == SearchType.job
              ? _buildJobResults(ref)
              : _buildWorkerResults(ref),
        ),
      ],
    ),
  );
}

 void _showMainFilterSheet(BuildContext context) {
    if (widget.searchType == SearchType.job) {
      ref.read(jobFilterSheetsProvider).showMainFilterSheet(context, ref);
    } else {
      ref.read(workerFilterSheetsProvider).showMainFilterSheet(context, ref);
    }
  }
  
  Widget _buildJobResults(WidgetRef ref) {
    final jobState = ref.watch(jobSearchNotifierProvider);
    if (jobState.isLoading && jobState.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (jobState.error != null) {
      return Center(child: Text('Error: ${jobState.error}'));
    }
    if (jobState.results.isEmpty) {
      return const Center(child: Text('No jobs found'));
    }

    return RefreshIndicator(
    onRefresh: () async {
      await ref.read(jobSearchNotifierProvider.notifier)
        .searchJobs(query: widget.searchQuery);
    },
    child:  ListView.builder(
      controller: _scrollController,
      itemCount: jobState.hasMore 
          ? jobState.results.length + 1 
          : jobState.results.length,
      itemBuilder: (context, index) {
        if (index >= jobState.results.length) {
          return jobState.hasMore
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('No more results')),
        );
        }
        return _buildJobItem(jobState.results[index]);
      },
    ),
  );
}

  Widget _buildJobItem(Job job) {
    return Card(
      child: ListTile(
        title: Text(job.title),
        subtitle: Text(job.location),
      ),
    );
  }

  Widget _buildWorkerResults(WidgetRef ref) {
    final workerState = ref.watch(workerSearchNotifierProvider);
    if (workerState.isLoading && workerState.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (workerState.error != null) {
      return Center(child: Text('Error: ${workerState.error}'));
    }
    if (workerState.results.isEmpty) {
      return const Center(child: Text('No workers found'));
    }


    return RefreshIndicator(
    onRefresh: () async {
      await ref.read(jobSearchNotifierProvider.notifier)
        .searchJobs(query: widget.searchQuery);
    },

    child:  ListView.builder(
      controller: _scrollController,
      itemCount: workerState.hasMore 
          ? workerState.results.length + 1 
          : workerState.results.length,
      itemBuilder: (context, index) {
        if (index >= workerState.results.length) {
          return workerState.hasMore
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('No more results')),
        );
        }
        return _buildWorkerItem(workerState.results[index]);
      },
    ),
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

// class FilterChipsRow extends ConsumerWidget {
//   final SearchType searchType;
  
//   const FilterChipsRow({
//     super.key,
//     required this.searchType,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           if (searchType == SearchType.job) ...[
//             _buildJobFilterChip('Full-time', ref),
//             _buildJobFilterChip('Remote', ref),
//           ] else ...[
//             _buildWorkerFilterChip('Available Now', ref),
//             _buildWorkerFilterChip('Verified', ref),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildJobFilterChip(String label, WidgetRef ref) {
//     return FilterChip(
//       label: Text(label),
//       onSelected: (selected) {
//         ref.read(jobSearchNotifierProvider.notifier).searchJobs();
//       },
//     );
//   }

//   Widget _buildWorkerFilterChip(String label, WidgetRef ref) {
//     return FilterChip(
//       label: Text(label),
//       onSelected: (selected) {
//         ref.read(workerSearchNotifierProvider.notifier).searchWorkers();
//       },
//     );
//   }
// }