// screens/workers_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/get_workers_provider.dart';
import 'package:workdey_frontend/core/providers/saved_worker_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/workers/wokers_card.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';
import 'package:workdey_frontend/shared/enum/search_type.dart';

class WorkersScreen extends ConsumerStatefulWidget {
  const WorkersScreen({super.key});

  @override
  ConsumerState<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends ConsumerState<WorkersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadInitialWorkers();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (newCategory != _currentCategory) {
  //     _currentCategory = newCategory;
  //     _loadInitialWorkers();
  //   }
  // }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    
    if (maxScroll - currentScroll <= delta) {
      final notifier = ref.read(workersNotifierProvider.notifier);
      if (notifier.hasMore) {
        notifier.loadNextPage();
      }
    }
  }

  Future<void> _loadInitialWorkers() async {
    await ref.read(workersNotifierProvider.notifier).loadInitialWorkers(
  
    );
  }

  @override
  Widget build(BuildContext context) {
    final workersState = ref.watch(workersNotifierProvider);

    return Scaffold(
      appBar: CustomAppBar(
         searchType: SearchType.worker,
        showSearchBar: true,
        actionButton: TextButton(
    onPressed: () => Navigator.pushNamed(context, AppRoutes.postWorker),
    child: const Text(
      'Workers Card',
      style: TextStyle(color: Color(0xFF3E8728)),
    ),
  ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadInitialWorkers,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  workersState.maybeWhen(
  loading: () => const SliverFillRemaining(
    child: Center(child: CircularProgressIndicator()),
  ),
  error: (error, stack) => SliverFillRemaining(
    child: Center(child: Text('Error: ${error.toString()}')),
  ),
  orElse: () {
    final data = workersState.value;
    if (data == null || data.results.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
             'Select a category to find workers',
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= data.results.length) {
            return ref.read(workersNotifierProvider.notifier).hasMore
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink();
          }
          return WorkerCard(
            worker: data.results[index],
            onBookmarkPressed: (workerId) {
              final isCurrentlySaved = data.results[index].isSaved;
              ref.read(savedWorkersProvider.notifier)
                  .toggleSave(workerId, isCurrentlySaved);
            },
          );
        },
        childCount: data.results.length + 
            (ref.read(workersNotifierProvider.notifier).hasMore ? 1 : 0),
      ),
    );
  },
),],
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