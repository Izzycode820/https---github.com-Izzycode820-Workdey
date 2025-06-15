// screens/workers_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/get_workers_provider.dart';
import 'package:workdey_frontend/core/providers/saved_worker_provider.dart';
import 'package:workdey_frontend/features/search_filter/search_bar_widget.dart';
import 'package:workdey_frontend/features/search_filter/search_filter_provider.dart';
import 'package:workdey_frontend/features/workers/wokers_card.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';

class WorkersScreen extends ConsumerStatefulWidget {
  const WorkersScreen({super.key});

  @override
  ConsumerState<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends ConsumerState<WorkersScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _currentCategory;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadInitialWorkers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newCategory = ref.read(searchFilterProvider).category;
    if (newCategory != _currentCategory) {
      _currentCategory = newCategory;
      _loadInitialWorkers();
    }
  }

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
    final category = ref.read(searchFilterProvider).category;
    await ref.read(workersNotifierProvider.notifier).loadInitialWorkers(
      category: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    final workersState = ref.watch(workersNotifierProvider);
    final filterState = ref.watch(searchFilterProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchBarWidget(),
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
            filterState.category != null
                ? 'No workers found for this category'
                : 'Select a category to find workers',
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